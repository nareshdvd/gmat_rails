class AddQuestionCountToQuestionGroup < ActiveRecord::Migration
  def change
    add_column :question_groups, :question_count, :integer, default: 1
    add_index :question_groups, [:question_count], name: :idx_qcount_on_qgroups
  end
end
