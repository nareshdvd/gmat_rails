class FixColumnExplainationToExplanation < ActiveRecord::Migration
  def change
    rename_column :questions, :explaination, :explanation
  end
end
