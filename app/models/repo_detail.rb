class RepoDetail < OpenStruct
  attr_reader :service

  def self.service(user)
    @service ||= GithubService.new(user)
  end

  def self.find_details(user, repos)
    service(user).repo_details(user, repos).map do |repo|
      RepoDetail.new(repo)
    end
  end
end
