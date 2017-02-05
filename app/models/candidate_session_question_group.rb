class CandidateSessionQuestionGroup < ActiveRecord::Base
  belongs_to :candidate_session
  belongs_to :question_group
  has_many :session_question_group_questions
  after_create :load_questions

  def category
    question_group.category
  end

  def level
    question_group.level
  end
  def load_questions
    pre_ques_group = candidate_session.candidate_session_question_groups.where("id != ?", self.id).last
    if pre_ques_group.present?
      old_count = pre_ques_group.session_question_group_questions.last.question_number
    else
      old_count = 0
    end
    question_group.questions.each do |question, inx|
      session_question_group_questions.create(question_id: question.id, question_number: old_count + 1)
      old_count += 1
    end
  end

  # this method should not be called in case category of question_group is GmatConstant::PASSAGES, as there are more than one question in this question group, also these kind of questions were not included in any logic of incrementing or decrementing of levels
  def is_correct?
    session_question_group_questions.first.option_id == question_group.questions.first.options.where(is_correct: true).first.id
  end

  def is_done?
    session_question_group_questions.where(option_id: nil).blank?
  end
end
