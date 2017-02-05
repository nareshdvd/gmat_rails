class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :description
      t.integer :option_count
      t.references :level, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
