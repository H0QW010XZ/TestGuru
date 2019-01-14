class Answer < ApplicationRecord
  MAX_ANSWERS = 4

  belongs_to :question

  scope :true_answers, -> { where(correct: true) }

  validates :body, presence: true
  validate :correct_answers, on: :create
  validate :answers_count, on: :create

  private

  def answers_count
    if question.answers.count >= MAX_ANSWERS
      errors.add(:answers_count, "Should be #{MAX_ANSWERS} answers maximum.")
    end
  end

  def correct_answers
    if question.answers.where(correct: true).count >= 1
      errors.add(:answers_correct, "Only one correct answer can exist")
    end
  end
end
