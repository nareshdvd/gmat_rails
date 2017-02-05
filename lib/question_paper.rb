module Paper
  class QuestionPaper

  end

  class QuestionGroup

  end

  class Question

  end

  class Option

  end

  class Candidate
    def create_session
      candidate_sessions.create(token: SecureRandom.hex(25), is_active: true)
    end

    def current_session
      if (candidate_session = last_session).present? && candidate_session.is_active
        return candidate_session 
      else
        return nil
      end
    end

    def last_session
      candidate_sessions.last
    end
  end

  class CandidateSession
    TOTAL_QUESTION_GROUPS = 29
    PASSAGE_QUESTION_POSITIONS = [7, 15, 22, 29]

    def current_question_group
      question_groups.last
    end

    def last_question_group

    end

    def add_question_group

    end
  end

  class SessionQuestionGroup

  end
end