class Answer < ApplicationRecord
  MAX_ANSWERS = 4

  validates :body, presence: true
  validate :answers_count, on: :create

  belongs_to :question

  scope :true_answers, -> { where(correct: true) }

  private

  def answers_count
    if question.answers.count >= MAX_ANSWERS
      errors.add(:answers_count, "Should be #{MAX_ANSWERS} answers maximum.")
    end
  end

end
