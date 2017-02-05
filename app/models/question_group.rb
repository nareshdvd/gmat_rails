class QuestionGroup < ActiveRecord::Base
  has_many :questions
  belongs_to :category
  belongs_to :level
  accepts_nested_attributes_for :questions
end
