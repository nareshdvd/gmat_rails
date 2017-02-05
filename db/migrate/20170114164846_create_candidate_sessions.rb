class CreateCandidateSessions < ActiveRecord::Migration
  def change
    create_table :candidate_sessions do |t|
      t.string :token
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
