class QuestionsController < ApplicationController
  before_action :set_test, only: %i[new create]
  before_action :set_question, only: %i[show destroy edit update]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_from_question_not_found

  def show; end

  def edit; end

  def new
    @question = @test.questions.new
  end

  def create
    @question = @test.questions.new(question_params)

    if @question.save
      redirect_to @question, success: 'Question was created successfully!'
    else
      render :new
    end
  end

  def update
    if @question.update(question_params)
      redirect_to @question, success: 'Question was updated successfully!'
    else
      render :edit
    end
  end

  def destroy
    @question.destroy!

    redirect_to test_path(@question.test), success: 'Question was deleted successfully!'
  end

  private

  def set_test
    @test = Test.find(params[:test_id])
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:body)
  end

  def rescue_from_question_not_found
    render plain: 'Question not found'
  end
end
