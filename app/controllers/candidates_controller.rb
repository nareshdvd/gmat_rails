class CandidatesController < ApplicationController
  before_filter :get_session, only: [:start_test, :show_question, :answer_question]
  before_filter :set_candidate, only: [:start_test, :show_question, :answer_question]
  skip_before_filter :authenticate_user!, only: [:new, :create]
  def new
    respond_to do |format|
      @candidate = Candidate.new
      format.html {render template: "candidates/register"}
    end
  end

  def create
    respond_to do |format|
      @candidate = Candidate.create(new_candidate_params)
      sign_in(@candidate)
      format.html {redirect_to start_test_path}
    end
  end

  def get_session
    set_candidate
    @candidate_session = @candidate.get_session()
  end

  def set_candidate
    @candidate = Candidate.find_by_id(current_user.id)
  end

  def show_message
    respond_to do |format|
      format.html {render template: "shared/show_message"}
    end
  end

  def start_test
    respond_to do |format|
      if @candidate_session.blank?
        if @candidate.eligible_for_new_session?
          @candidate_session = @candidate.create_session()
          session_question_group = @candidate_session.create_session_question_group()
          format.html {redirect_to candidate_question_path(session_question_group, session_question_group.session_question_group_questions.first)}
        else
          flash[:error_message] = "Next session will be opened for you after #{@candidate.new_session_eligibility_datetime}"
          format.html {redirect_to show_message_path}
        end
      else
        if @candidate_session.candidate_session_question_groups.count == 0
          session_question_group = @candidate_session.create_session_question_group()
          format.html {redirect_to candidate_question_path(session_question_group, session_question_group.session_question_group_questions.first)}
        else
          last_session_question_group = @candidate_session.last_session_question_group
          if last_session_question_group.is_done?
            session_question_group = @candidate_session.create_session_question_group()
            format.html {redirect_to candidate_question_path(session_question_group, session_question_group.session_question_group_questions.first)}
          else
            format.html {redirect_to candidate_question_path(last_session_question_group, last_session_question_group.session_question_group_questions.where(option_id: nil).first)}
          end
        end
      end
    end
  end

  def show_question
    session_question_group_id = params[:session_question_group_id].to_i
    session_question_group_question_id = params[:session_question_group_question_id].to_i
    respond_to do |format|
      if @candidate_session.blank?
        flash[:error_message] = "Error Occurred 6"
        format.html {redirect_to show_message_path}
      else
        if @candidate_session.candidate_session_question_groups.last.id == session_question_group_id
          @session_question_group = @candidate_session.candidate_session_question_groups.last
          if (@session_question_group_question = @session_question_group.session_question_group_questions.where("option_id IS NULL").first).id == session_question_group_question_id
            format.html
          else
            flash[:error_message] = "Error Occurred 5"
            format.html {redirect_to show_message_path}
          end
        else
          flash[:error_message] = "Error Occurred 4"
          format.html {redirect_to show_message_path}
        end
      end
    end
  end

  def answer_question
    option_id = answer_option_params[:option_id]
    session_question_group_id = params[:session_question_group_id].to_i
    session_question_group_question_id = params[:session_question_group_question_id].to_i



    respond_to do |format|
      if @candidate_session.blank?
        flash[:error_message] = "Error Occurred 1"
        format.html {redirect_to show_message_path}
      else

        if (@session_question_group = @candidate_session.candidate_session_question_groups.last).id == session_question_group_id
          if (@session_question_group_question = @session_question_group.session_question_group_questions.where("option_id IS NULL").first).id == session_question_group_question_id
            @session_question_group_question.option_id = option_id
            @session_question_group_question.save()
            if @session_question_group.is_done?
              @session_question_group = @candidate_session.create_session_question_group()
              format.html {redirect_to candidate_question_path(@session_question_group, @session_question_group.session_question_group_questions.first)}
            else
              format.html {redirect_to candidate_question_path(@session_question_group, @session_question_group.session_question_group_questions.where("option_id IS NULL").first)}
            end
          else
            flash[:error_message] = "Error Occurred 2"
            format.html {redirect_to show_message_path}
          end
        else
          flash[:error_message] = "Error Occurred 2"
          format.html {redirect_to show_message_path}
        end


        if @candidate_session.candidate_session_question_groups.last.id == session_question_group_id
          @session_question_group = @candidate_session.candidate_session_question_groups.last
          if (@session_question_group_question = @session_question_group.session_question_group_questions.where("option_id IS NULL").first).id == session_question_group_question_id
            @session_question_group_question.option_id = option_id
            @session_question_group_question.save()
            if @session_question_group.is_done?
              @session_question_group = @candidate_session.create_session_question_group()
            end
            format.html {redirect_to candidate_question_path(session_question_group, session_question_group.session_question_group_questions.first)}
          else
            flash[:error_message] = "Error Occurred 2"
            format.html {redirect_to show_message_path}
          end
        else
          flash[:error_message] = "Error Occurred 3"
          format.html {redirect_to show_message_path}
        end
      end
    end
  end

  private

  def new_candidate_params
    params.require(:candidate).permit(:email, :password, :password_confirmation)
  end

  def answer_option_params
    params.require(:session_question_group_question).permit(:option_id)
  end
end
