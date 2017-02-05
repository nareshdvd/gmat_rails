class CreateSessionQuestionGroupQuestions < ActiveRecord::Migration
  def change
    create_table :session_question_group_questions do |t|
      t.references :candidate_session_question_group, index: {:name => "inx_ses_que_gr_que_on_can_ses_que_gr_id"}, foreign_key: true
      t.references :question, index: true, foreign_key: true
      t.references :option, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
