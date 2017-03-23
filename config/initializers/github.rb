class GithubService
  attr_reader :token, :connection

  def initialize(user)
    @connection    = Faraday.new("https://api.github.com") do |faraday|
      faraday.params[:client_id] = ENV["GITHUB_CLIENT_ID"]
      faraday.params[:client_secret] = ENV["GITHUB_SECRET_KEY"]
      faraday.adapter  Faraday.default_adapter
    end
    # @token  = user.token
    # @connection = Faraday.new("https://api.github.com") do |faraday|
    #   faraday.params[:access_token] = user.token
    #   faraday.adapter  Faraday.default_adapter
    # end
  end

  def starred_repos(user)
    parse(connection.get("users/#{user[:username]}/starred"))
  end

  def followers(user)
    parse(connection.get("users/#{user[:username]}/followers"))
  end

  def following(user)
    parse(connection.get("users/#{user[:username]}/following"))
  end

  private

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
