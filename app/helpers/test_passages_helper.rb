module TestPassagesHelper
  def all_questions(test_passage)
    "Questions: #{test_passage.test.questions.count}"
  end

  def result_message(test_passage)
    result = test_passage.result_in_percentages

    if test_passage.successful?
      render 'status', result: result, success: true
    else
      render 'status', result: result, success: false
    end
  end
end
