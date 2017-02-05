class CandidateSession < ActiveRecord::Base
  TOTAL_QUESTION_GROUPS = 29
  PASSAGE_QUESTION_POSITIONS = [7, 15, 22, 29]

  belongs_to :candidate, foreign_key: :user_id, class_name: "Candidate"
  has_many :candidate_session_question_groups

  def finish_time
    created_at + GmatConstant.candidate_session_time.hours
  end

  def next_session_min_time
    finish_time + GmatConstant.next_session_enabled_after.hours
  end

  def finished?
    expired? || questions_finished?
  end

  def expired?
    finish_time < Time.now
  end

  def questions_finished?
    candidate_session_question_groups.count == GmatConstant.get('question_settings')['total_questions']
  end

  def last_session_question_group
    candidate_session_question_groups.last
  end

  def create_session_question_group
    category = get_next_category_to_pick_question_group_from
    # skip level condition in case category is Passages
    if category.title == GmatConstant::PASSAGES
      question_group = QuestionGroup.where(category_id: category.id).where("id NOT IN (?)", candidate.candidate_sessions.preload(candidate_session_question_groups: :question_group).collect(&:candidate_session_question_groups).flatten.collect(&:question_group).flatten.collect(&:id)).first
    else
      if candidate_session_question_groups.count == 0
        level = Level.find_by_title(Level::MEDIUM)
      elsif candidate_session_question_groups.count == 1
        if candidate_session_question_groups.first.is_correct?
          level = candidate_session_question_groups.last.level
        else
          level = Level.find_by_title(Level::EASY)
        end
      else
        last_two_session_question_groups = candidate_session_question_groups.joins(question_group: :category).where("categories.title != ?", GmatConstant::PASSAGES).last(2)
        if last_two_session_question_groups.last.is_correct?
          if last_two_session_question_groups.last.level.id == last_two_session_question_groups.first.level.id
            if last_two_session_question_groups.first.is_correct?
              tmp_level = Level.where("id > ?", last_two_session_question_groups.last.level.id).first
              if tmp_level.present?
                level = tmp_level
              else
                level = last_two_session_question_groups.last.level
              end
            else
              level = last_two_session_question_groups.last.level
            end
          else
            level = last_two_session_question_groups.last.level
          end
        else
          tmp_level = Level.where("id < ?", last_two_session_question_groups.last.level.id).last
          if tmp_level.present?
            level = tmp_level
          else
            level = last_two_session_question_groups.last.level
          end
        end
      end
      not_in_ids = candidate.candidate_sessions.preload(candidate_session_question_groups: :question_group).collect(&:candidate_session_question_groups).flatten.collect(&:question_group).flatten.collect(&:id)
      if not_in_ids.present?
        question_group = QuestionGroup.where(category_id: category.id, level_id: level.id).where("id NOT IN (?)", candidate.candidate_sessions.preload(candidate_session_question_groups: :question_group).collect(&:candidate_session_question_groups).flatten.collect(&:question_group).flatten.collect(&:id)).first
      else
        question_group = QuestionGroup.where(category_id: category.id, level_id: level.id).first
      end
    end
    return candidate_session_question_groups.create(question_group_id: question_group.id)
  end

  def get_next_category_to_pick_question_group_from
    question_group_count_by_category_yet = candidate_session_question_groups.joins(question_group: :category).select("question_groups.id").group("categories.id").count
    question_group_count_yet = question_group_count_by_category_yet.values.sum
    # condition for showing passage question group
    if PASSAGE_QUESTION_POSITIONS.include?(question_group_count_yet + 1)
      category = Category.find_by_title(GmatConstant::PASSAGES)
    else
      question_group_count_by_category_yet.delete(Category.find_by_title(GmatConstant::PASSAGES).id)
      category_with_min_questions_picked = Hash[*question_group_count_by_category_yet.min_by{|k, v| v}]
      # find category with minimum question groups shown to user for current session
      if category_with_min_questions_picked.present?
        category = Category.find_by_id(category_with_min_questions_picked.keys.first)
      else
        # in case there are no question groups added yet to the session, pick any category except Passage Category
        if Random.rand(2) == 0
          category = Category.where("title != ?", GmatConstant::PASSAGES).first
        else
          category = Category.where("title != ?", GmatConstant::PASSAGES).last
        end
      end
    end
    return category
  end
end
