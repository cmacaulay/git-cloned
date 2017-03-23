class Follower < OpenStruct
  attr_reader :service

  def self.service(user)
    @service ||= GithubService.new(user)
  end

  def self.find_followers(user)
    service(user).followers(user).map do |repo|
      Follower.new(repo)
    end
  end
end
