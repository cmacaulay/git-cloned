class User < ApplicationRecord
  attr_reader :username#:service
  #
  # def initialize
  #   # @service ||= GithubService.new
  #   @username = self.username
  # end

  def starred_repos
    response = parse(Faraday.get("https://api.github.com/users/#{self[:username]}/starred"))
  end

  private

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
