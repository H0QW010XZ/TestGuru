module TestPassagesHelper
  SUCCESS_PERCENTAGES = 85

  def all_questions(test_passage)
    "Questions: #{test_passage.test.questions.count}"
  end

  def result_message(test_passage)
    result = result_in_percentages(test_passage)

    if successful?(test_passage)
      content_tag(:h2, "Your result is #{result}%, you passed the test.")
    else
      content_tag(:h2, "Your result is #{result}%, you failed the test.")
    end
  end

  def result_in_percentages(test_passage)
    (test_passage.correct_questions * 100.0 / test_passage.test.questions.count).round(2)
  end

  def successful?(test_passage)
    result_in_percentages(test_passage) >= SUCCESS_PERCENTAGES if test_passage.completed?
  end
end
