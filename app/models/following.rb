class Following < OpenStruct
  attr_reader :service

  def self.service(user)
    @service ||= GithubService.new(user)
  end

  def self.find_followers(user)
    service(user).following(user).map do |repo|
      Follower.new(repo)
    end
  end
end
