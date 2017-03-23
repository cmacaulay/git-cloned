class Repo < OpenStruct
  attr_reader :service

  def self.service(user)
    @service ||= GithubService.new(user)
  end

  def self.find_starred(user)
    service(user).starred_repos(user).map do |repo|
      Repo.new(repo)
    end
  end

  def self.find_repos(user)
    service(user).repos(user).map do |repo|
      Repo.new(repo)
    end
  end
end
