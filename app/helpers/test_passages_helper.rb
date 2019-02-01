module TestPassagesHelper
  def all_questions(test_passage)
    "Questions: #{test_passage.test.questions.count}"
  end

  def result_message(test_passage)
    test_passage.result_in_percentages
  end
end
