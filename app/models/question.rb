class Question < ActiveRecord::Base
  belongs_to :category
  belongs_to :level
  has_many :options, dependent: :destroy
  has_many :session_questions
  belongs_to :question_group
  accepts_nested_attributes_for :options
end
