class Candidate < User
  has_many :candidate_sessions, foreign_key: :user_id
  has_one :current_candidate_session, -> { where is_active: true }, class_name: 'CandidateSession', foreign_key: :user_id
  has_one :last_candidate_session, -> { order :created_at }, class_name: 'CandidateSession', foreign_key: :user_id
  def create_session
    session = self.candidate_sessions.build(token: SecureRandom.hex(25), is_active: true)
    session.save()
    return session
  end

  def get_session
    return self.current_candidate_session
  end

  def eligible_for_new_session?
    session = self.last_candidate_session
    curr_time = Time.now
    return session.blank? || (session.finished? && ((session.next_session_min_time) <= curr_time))
  end
end