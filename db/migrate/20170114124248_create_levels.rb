class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels do |t|
      t.string :title
      t.text :description
      t.integer :question_limit
      t.integer :question_score

      t.timestamps null: false
    end
  end
end
