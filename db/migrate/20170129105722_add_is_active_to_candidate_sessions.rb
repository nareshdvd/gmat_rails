class AddIsActiveToCandidateSessions < ActiveRecord::Migration
  def change
    add_column :candidate_sessions, :is_active, :boolean
  end
end
