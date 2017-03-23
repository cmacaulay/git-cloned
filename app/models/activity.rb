class Activity < OpenStruct
  attr_reader :service

  def self.service(user)
    @service ||= GithubService.new(user)
  end

  def self.find_activity(user)
    service(user).activity(user).map do |f|
      Activity.new(f)
    end
  end
end
