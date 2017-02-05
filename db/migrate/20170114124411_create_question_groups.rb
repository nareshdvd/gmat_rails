class CreateQuestionGroups < ActiveRecord::Migration
  def change
    create_table :question_groups do |t|
      t.text :description
      t.references :category, index: true, foreign_key: true
      t.references :level, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
