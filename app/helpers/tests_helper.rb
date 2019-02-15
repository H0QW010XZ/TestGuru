module TestsHelper
  def github_url(author, repo)
    "https://github.com/#{author}/#{repo}"
  end

  def test_header(test)
    action = test.new_record? ? t('helpers.admin_tests.create') : t('helpers.admin_tests.edit')
    "#{action} #{t('helpers.admin_tests.test')} «#{test.title}»"
  end
end
