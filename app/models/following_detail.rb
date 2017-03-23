class FollowingDetail < OpenStruct
  attr_reader :service

  def self.service(user)
    @service ||= GithubService.new(user)
  end

  def self.find_following_details(user, followers)
    service(user).user_details(user, followers).map do |f|
      FollowingDetail.new(f)
    end
  end
end
