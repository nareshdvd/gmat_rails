class GmatConstant
  PASSAGES = 'Passages'
  include Singleton
  def initialize()
    @constants = {}
  end

  def self.set(key, val)
    return self.instance.set(key, val)
  end

  def self.get(key)
    return self.instance.get(key)
  end

  def set(key, val)
    @constants[key] = val
  end

  def get(key)
    @constants[key]
  end
end
GmatConstant.set('option_count', 4)
GmatConstant.set('candidate_session_time', 1)
GmatConstant.set('next_session_enabled_after', 1)
GmatConstant.set('question_settings', {
  'total_questions' => 41,
  'passage_question_positions' => [5, 13, 27, 39],
  'increase_level' => 2,
  'decrease_level' => 1,
  'first_question_level' => 'medium'
});