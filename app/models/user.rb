class User < ApplicationRecord
  attr_reader :username#:service
  #
  # def initialize
  #   # @service ||= GithubService.new
  #   @username = self.username
  # end

  def starred_repos
    parse(Faraday.get("https://api.github.com/users/#{self[:username]}/starred"))
  end

  def followers
   parse(Faraday.get("https://api.github.com/users/#{self[:username]}/followers"))
  end
  
  def following
  parse(Faraday.get("https://api.github.com/users/#{self[:username]}/following"))
  end

  private

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
