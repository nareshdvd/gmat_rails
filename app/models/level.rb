class Level < ActiveRecord::Base
  EASY = "Easy"
  MEDIUM = "medium"
  TOUGH = "tough"
  has_many :questions
end
