class AddExplainationToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :explaination, :text
  end
end
