class SessionQuestion < ActiveRecord::Base
  belongs_to :candidate_session
  belongs_to :question
  belongs_to :option

  def is_answered?
    return !self.option_id.blank?
  end

  def is_correct?
    return self.option.is_correct
  end
end
