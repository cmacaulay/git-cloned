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

  def self.find_commits(user, activity)
    activity.map do |activity|
      by_repo = {}
      if activity.type == "PushEvent"
        activity.payload[:commits].each do |commit|
          by_repo[activity.repo[:name]] = commit
        end
      end
      by_repo
    end
  end

  def self.find_activity_of_followed(user, followed)
    service(user).activity_of_followed(user, followed).map do |f|
      Activity.new(f)
    end
  end
end
