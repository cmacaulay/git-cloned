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
  end

  def activity_of_followed
    Activity.find_activity_of_followed(self, self.following)
  end

  private

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
