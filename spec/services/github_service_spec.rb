require 'rails_helper'

describe GithubService do
  attr_reader :service, :user

  before(:each) do
    @user   = User.create!({username: "cmacaulay",
                       token: ENV['USER_TOKEN']
                     })
    @github = User.service(user)
  end

  describe '#starred_repos' do
    it 'finds all starred repos' do
      VCR.use_cassette("#starred_repos") do
        starred_repos = @github.starred_repos(user)
        starred_repo  = starred_repos.first

        expect(starred_repos).to be_an(Array)
        expect(starred_repos.count).to eq(3)

        expect(starred_repo[:name]).to eq("rails_engine")
        expect(starred_repo[:full_name]).to eq("Ryanspink1/rails_engine")
        expect(starred_repo).to have_key(:description)
      end
    end
  end
end
