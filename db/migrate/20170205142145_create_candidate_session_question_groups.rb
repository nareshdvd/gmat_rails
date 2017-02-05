class CreateCandidateSessionQuestionGroups < ActiveRecord::Migration
  def change
    create_table :candidate_session_question_groups do |t|
      t.references :candidate_session, index: true, foreign_key: true
      t.references :question_group, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
