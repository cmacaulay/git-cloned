class Organization < OpenStruct
  attr_reader :service

  def self.service(user)
    @service ||= GithubService.new(user)
  end

  def self.find_organizations(user)
    service(user).organizations(user).map do |org|
      Organization.new(org)
    end
  end
end
