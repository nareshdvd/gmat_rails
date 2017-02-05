class AddQuestionNumberToSessionQuestionGroupQuestions < ActiveRecord::Migration
  def change
    add_column :session_question_group_questions, :question_number, :integer
    add_index :session_question_group_questions, :question_number, name: "inx_qno_on_ses_que_gr_que"
  end
end
