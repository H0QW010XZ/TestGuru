class TestPassage < ApplicationRecord

  SUCCESS_PERCENTAGES = 85

  belongs_to :test
  belongs_to :user
  belongs_to :current_question, class_name: :Question, optional: true

  before_validation :before_validation_set_first_question

  validates :score, presence: true

  scope :successful, lambda {
    where("result >= ?", SUCCESS_PERCENTAGES)
  }

  def accept!(answer_ids)
    self.correct_questions += 1 if correct_answer?(answer_ids)
    set_result
    save!
  end

  def completed?
    current_question.nil?
  end

  def question_number
    test.questions.order(:id).where('id <= ?', current_question).count
  end

  def result_in_percentages
    (correct_questions * 100.0 / test.questions.count).round(2)
  end

  def successful?
    result_in_percentages >= SUCCESS_PERCENTAGES if completed?
  end


  private

  def before_validation_set_first_question
    self.current_question = next_question
  end

  def correct_answer?(answer_ids)
    correct_answers.ids.sort == answer_ids.to_a.map(&:to_i).sort
  end

  def next_question
    if current_question.nil?
      test.questions.first
    else
      test.questions.order(:id).where('id > ?', current_question.id).first
    end
  end

  def correct_answers
    current_question.answers.correct
  end

  def set_result
    self.result = result_in_percentages
  end
end
