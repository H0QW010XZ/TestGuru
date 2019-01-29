module TestPassagesHelper
  def all_questions
    "Questions: #{@test_passage.test.questions.count}"
  end

  def result_message(result)
    if @test_passage.successful?
      content_tag(:h2,
                  "Your result is #{result}%, you passed the test.",
                  class: 'result_success')
    else
      content_tag(:h2,
                  "Your result is #{result}%, you failed the test.",
                  class: 'result_fail')
    end
  end
end
