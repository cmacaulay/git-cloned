require 'rails_helper'

describe GithubService do
  attr_reader :service, :user

  before(:each) do
    @user   = User.create!({username: "cmacaulay",
                       token: ENV['USER_TOKEN']
                     })
  end

  describe '#starred_repos' do
    it 'finds all starred repos' do
      VCR.use_cassette("#starred_repos") do
        starred_repos = user.starred_repos
        starred_repo  = starred_repos.first

        expect(starred_repos).to be_an(Array)
        expect(starred_repos.count).to eq(3)

        expect(starred_repo[:name]).to eq("rails_engine")
        expect(starred_repo[:full_name]).to eq("Ryanspink1/rails_engine")
      end
    end
  end

  describe "#followers" do
    it "finds all users who follow a user" do
      VCR.use_cassette("#followers") do
        followers = user.followers
        follower  = followers.first

        expect(followers).to be_an(Array)
        expect(followers.count).to eq(1)

        expect(follower[:login]).to eq("meyerhoferc")
      end
    end
  end
end
