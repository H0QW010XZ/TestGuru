module AdminTestsHelper
  def test_header(test)
    action = test.new_record? ? 'Create' : 'Edit'
    "#{action} «#{test.title}» test"
  end
end
