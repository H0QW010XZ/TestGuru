module TestsHelper
  def current_year
    Time.current.year
  end

  def github_url(author, repo)
    "https://github.com/#{author}/#{repo}"
  end

  def test_header(test)
    action = test.new_record? ? 'Create' : 'Edit'
    "#{action} test"
  end
end
