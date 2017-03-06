class QuestionGroupsController < ApplicationController
  before_action :set_question_group, only: [:show, :edit, :update, :destroy]

  # GET /question_groups
  # GET /question_groups.json
  def index
    if params[:category_id].present?
      @question_groups = QuestionGroup.preload(:category, :level).all
    else
      @question_groups = QuestionGroup.preload(:category, :level).where(category_id: params[:category_id])
    end
  end

  # GET /question_groups/1
  # GET /question_groups/1.json
  def show
  end

  # GET /question_groups/new
  def new
    @question_group = QuestionGroup.new
    4.times { @question_group.questions.build }
    @question_group.questions.each {|question| 5.times { question.options.build } }
    respond_to do |format|
      format.html {render template: 'question_groups/new/new'}
    end
  end

  # GET /question_groups/1/edit
  def edit
    @question_group = QuestionGroup.find_by_id(params[:id])
    question = @question_group.questions.first
    respond_to do |format|
      format.html {render template: 'question_groups/new/edit'}
    end
  end

  # POST /question_groups
  # POST /question_groups.json
  def create
    @question_group = QuestionGroup.new(question_group_params)
    if @question_group.category.title != "Passages"
      @question_group.questions.each_with_index do |question, inx|
        next if inx == 0
        @question_group.questions.delete(question)
      end
    end
    respond_to do |format|
      if @question_group.save
        format.html { redirect_to question_groups_url, notice: "Question group was successfully created. unique id is: #{@question_group.id}" }
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
        format.html { redirect_to question_groups_url, notice: 'Question group was successfully updated.' }
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
      params.require(:question_group).permit(:description, :category_id, :level_id, questions_attributes: [:id, :description, :option_count, :explaination, {options_attributes: [:id, :description, :is_correct]}])
    end
end
