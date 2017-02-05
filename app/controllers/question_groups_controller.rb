class QuestionGroupsController < ApplicationController
  before_action :set_question_group, only: [:show, :edit, :update, :destroy]

  # GET /question_groups
  # GET /question_groups.json
  def index
    @question_groups = QuestionGroup.all
  end

  # GET /question_groups/1
  # GET /question_groups/1.json
  def show
  end

  # GET /question_groups/new
  def new
    # @question_group = QuestionGroup.new(category_id: 2)
    # @category = Category.find(@question_group.category_id)
    # new_question_inx = Category.find(@question_group.category_id).question_groups.count + 1
    # @question_group.save()
    # question = @question_group.questions.build(description: "Question #{new_question_inx} #{@category.title}", level_id: Level.find_by_title("High").id)
    # question.save

    @question_group = QuestionGroup.new
    question = @question_group.questions.build
    4.times do |i|
      question.options.build
    end
    respond_to do |format|
      format.html {render template: 'questions/new_passage_question'}
    end
  end

  # GET /question_groups/1/edit
  def edit
    @question_group = QuestionGroup.find_by_id(params[:id])
    question = @question_group.questions.first
    respond_to do |format|
      format.html {render template: 'questions/edit_passage_question'}
    end
  end

  # POST /question_groups
  # POST /question_groups.json
  def create
    @question_group = QuestionGroup.new(question_group_params)

    respond_to do |format|
      if @question_group.save
        format.html { redirect_to @question_group, notice: 'Question group was successfully created.' }
        format.json { render :show, status: :created, location: @question_group }
      else
        format.html { render :new }
        format.json { render json: @question_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /question_groups/1
  # PATCH/PUT /question_groups/1.json
  def update
    respond_to do |format|
      if @question_group.update(question_group_params)
        format.html { redirect_to @question_group, notice: 'Question group was successfully updated.' }
        format.json { render :show, status: :ok, location: @question_group }
      else
        format.html { render :edit }
        format.json { render json: @question_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /question_groups/1
  # DELETE /question_groups/1.json
  def destroy
    @question_group.destroy
    respond_to do |format|
      format.html { redirect_to question_groups_url, notice: 'Question group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question_group
      @question_group = QuestionGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_group_params
      params.require(:question_group).permit(:description, :category_id, questions_attributes: [:id, :description, :option_count, :category_id, :level_id, {options_attributes: [:id, :description]}])
    end
end
