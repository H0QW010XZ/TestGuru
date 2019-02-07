class QuestionsController < ApplicationController
  before_action :set_question, only: :show

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_from_question_not_found

  def show; end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def rescue_from_question_not_found
    render plain: 'Question not found'
  end
end
