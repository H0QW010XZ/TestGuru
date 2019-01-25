module QuestionsHelper
  def question_header(question)
    action = question.new_record? ? 'Create' : 'Edit'
    "#{action} question for test «#{question.test.title}»"
  end
end
