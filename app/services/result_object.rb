class ResultObject
  def initialize(res)
    @res = res
  end

  def success?
    @res.url.present?
  end

  def url
    @res&.html_url
  end
end
