class Following < OpenStruct
  attr_reader :service

  def self.service(user)
    @service ||= GithubService.new(user)
  end

  def self.find_following(user)
    service(user).following(user).map do |f|
      Follower.new(f)
    end
  end
end
