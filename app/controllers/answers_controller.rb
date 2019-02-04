class AnswersController < ApplicationController
  before_action :set_answer, only: %i[show edit update destroy]
  before_action :set_question, only: %i[new create]

  def show; end

  def new
    @answer = @question.answers.new
  end

  def edit; end

  def create
    @answer = Answer.new(answer_params)

    if @answer.save
      redirect_to @answer, success: 'Answer was created successfully!'
    else
      render :new
    end
  end

  def update
    if @answer.update(answer_params)
      redirect_to @answer, success: 'Answer was updated successfully!'
    else
      render :edit
    end
  end

  def destroy
    @answer.destroy!
    redirect_to @answer.question, success: 'Answer was deleted successfully!'
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body, :correct)
  end
end