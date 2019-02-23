class GistQuestionService
  def initialize(question, client: nil)
    @question = question
    @test = @question.test
    @client = client || default_client
  end

  def call
    gist = @client.create_gist(gist_params)
    ResultObject.new(gist)
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
    Octokit::Client.new(access_token: ENV['GIT_GIST_KEY'])
  end

  def gist_content
    [@question.body, *@question.answers.pluck(:body)].join("\n")
  end
end
