class Category < ActiveRecord::Base
  has_many :question_groups
end
