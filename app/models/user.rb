class User < ApplicationRecord
  attr_reader :username#:service
  #
  # def initialize
  #   # @service ||= GithubService.new
  #   @username = self.username
  # end

  def starred_repos
    # parse(Faraday.get("https://api.github.com/users/#{self[:username]}/starred"))
    parse(Faraday.get("https://api.github.com/#{self[:username]}/starred?token=#{self.token}"))
  end

  def followers
    client_id     = ENV["GITHUB_CLIENT_ID"]
    client_secret = ENV["GITHUB_SECRET_KEY"]
    auth          = "?client_id=#{client_id}&client_secret=#{client_secret}"
   parse(Faraday.get("https://api.github.com/users/#{self[:username]}/followers#{auth}"))
  end

  def following
    client_id     = ENV["GITHUB_CLIENT_ID"]
    client_secret = ENV["GITHUB_SECRET_KEY"]
    auth          = "?client_id=#{client_id}&client_secret=#{client_secret}"
    parse(Faraday.get("https://api.github.com/users/#{self[:username]}/following#{auth}"))
  end

  def repos
    client_id     = ENV["GITHUB_CLIENT_ID"]
    client_secret = ENV["GITHUB_SECRET_KEY"]
    auth          = "?client_id=#{client_id}&client_secret=#{client_secret}"
    parse(Faraday.get("https://api.github.com/users/#{self[:username]}/repos#{auth}"))
  end

  private

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
