class User < ApplicationRecord
  attr_reader :username, :service

  def self.from_github(auth, access_token)
    user = User.find_or_create_by(uid: auth["id"], provider: 'github')
      user.username   = auth["login"]
      user.name       = auth["name"]
      user.uid        = auth["id"]
      user.avatar     = auth["avatar_url"]
      user.token      = access_token
      user.save
      user
  end

  def followers
    Follower.find_followers(self)
  end

  def follower_details
    FollowerDetail.find_follower_details(self, self.followers)
  end

  def following
    Following.find_following(self)
  end

  def following_details
    FollowingDetail.find_following_details(self, self.following)
  end

  def repos
    Repo.find_repos(self)
  end

  def starred_repos
    Repo.find_starred(self)
  end

  def repo_details
    RepoDetail.find_details(self, self.repos)
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
