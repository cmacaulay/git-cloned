class User < ApplicationRecord
  attr_reader :username, :service

  def starred_repos
    Repo.find_starred(self)
  end

  def followers
    Follower.find_followers(self)
  end

  def following
    Following.find_following(self)
  end

  def repos
    Repo.find_repos(self)
  end

  def organizations
    Organization.find_organizations(self)
  end

  def activity
    Activity.find_activity(self)
    # client_id     = ENV["GITHUB_CLIENT_ID"]
    # client_secret = ENV["GITHUB_SECRET_KEY"]
    # auth          = "?client_id=#{client_id}&client_secret=#{client_secret}"
    # parse(Faraday.get("https://api.github.com/users/#{self[:username]}/events#{auth}"))
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
