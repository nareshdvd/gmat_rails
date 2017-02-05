class CreateSessionQuestions < ActiveRecord::Migration
  def change
    create_table :session_questions do |t|
      t.references :candidate_session, index: true, foreign_key: true
      t.references :question, index: true, foreign_key: true
      t.references :option, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
