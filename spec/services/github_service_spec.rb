require 'rails_helper'

describe GithubService do
  attr_reader :service, :username

  before(:each) do
    @github = GithubService.new
    @username = "cmacaulay"
  end

  describe '#starred_repos' do
    it 'finds all starred repos' do
      starred_repos = @github.starred_repos
      starred_repo  = starred_repos.first

      expect(starred_repos.count).to eq(3)
      expect(starred_repo[:name]).to eq("rails_engine")
      expect(starred_repo[:full_name]).to eq("Ryanspink1/rails_engine")
    end
  end
end
