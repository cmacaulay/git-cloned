class FollowerDetail < OpenStruct
  attr_reader :service

  def self.service(user)
    @service ||= GithubService.new(user)
  end

  def self.find_follower_details(user, followers)
    service(user).user_details(user, followers).map do |f|
      FollowerDetail.new(f)
    end
  end
end
