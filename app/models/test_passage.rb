class TestPassage < ApplicationRecord

  SUCCESS_PERCENTAGES = 85

  belongs_to :test
  belongs_to :user
  belongs_to :current_question, class_name: :Question, optional: true

  before_validation :before_validation_set_first_question

  validates :score, presence: true

  def accept!(answer_ids)
    if in_time?
      self.correct_questions += 1 if correct_answer?(answer_ids)
      set_result
      save!
    else
      self.current_question = nil
    end
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
    in_time? && result_in_percentages >= SUCCESS_PERCENTAGES if completed?
  end

  def passage_duration
    (Time.current - self.created_at).to_i
  end

  def duration_remain
    test.duration - passage_duration
  end

  def in_time?
    duration = test.duration

    duration.zero? || passage_duration <= duration
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
