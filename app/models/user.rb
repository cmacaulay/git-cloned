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

  def organizations
    # connection = Faraday.new(url: "https://api.github.com") do |faraday|
    #   faraday.params[:access_token] = self.token
    # end
    # response = connection.get "#{User.find_by(token: self.token)}/orgs"
    # # try = parse(response.body)
    # byebug

    client_id     = ENV["GITHUB_CLIENT_ID"]
    client_secret = ENV["GITHUB_SECRET_KEY"]
    auth          = "?client_id=#{client_id}&client_secret=#{client_secret}"
    parse(Faraday.get("https://api.github.com/users/#{self[:username]}/orgs#{auth}"))
  end


  def activity
    client_id     = ENV["GITHUB_CLIENT_ID"]
    client_secret = ENV["GITHUB_SECRET_KEY"]
    auth          = "?client_id=#{client_id}&client_secret=#{client_secret}"
    parse(Faraday.get("https://api.github.com/users/#{self[:username]}/events#{auth}"))
  end

  def activity_of_followed
    client_id     = ENV["GITHUB_CLIENT_ID"]
    client_secret = ENV["GITHUB_SECRET_KEY"]
    auth          = "?client_id=#{client_id}&client_secret=#{client_secret}"
    # parse(Faraday.get("https://api.github.com/users/#{self[:username]}/received_events#{auth}"))
    self.following.each do |f|
      return parse(Faraday.get("https://api.github.com/users/#{f[:login]}/events#{auth}"))
    end
  end


  private

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
