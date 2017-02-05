class SessionQuestionGroupQuestion < ActiveRecord::Base
  belongs_to :candidate_session_question_group
  belongs_to :question
  belongs_to :option
end
