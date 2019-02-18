class GistQuestionService

  def initialize(question, client: nil)
    @question = question
    @test = @question.test
    @client = client || default_client
  end

  def call
    @gist_answer = @client.create_gist(gist_params)
  end

  def success?
    @gist_answer[:html_url].present?
  end

  private

  def gist_params
    {
        description: I18n.translate('git_question_service.desc', title: @test.title),
        public: true,
        files: {
            'test-guru-question.txt' => {
                content: gist_content
            }
        }
    }
  end

  def default_client
    Octokit::Client.new(access_token: ENV['git_gist_key'])
  end

  def gist_content
    content = [@question.body]
    content += @question.answers.pluck(:body)
    content.join("\n")
  end
end
