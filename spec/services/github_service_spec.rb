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

  describe "#following" do
    it "finds all users who are following a user" do
      VCR.use_cassette("#following") do
        followers = user.following
        follower  = followers.first

        expect(followers).to be_an(Array)
        expect(followers.count).to eq(3)

        expect(follower[:login]).to eq("novohispano")
        expect(follower[:id]).to eq(1654034)
      end
    end
  end

  describe "#repos" do
    it "finds all repos that belong to user" do
      VCR.use_cassette("#repos") do
        repos = user.repos
        repo  = repos.first

        expect(repos).to be_an(Array)
        expect(repos.count).to eq(30)

        expect(repo[:id]).to eq(78127608)
        expect(repo[:name]).to eq("advanced-enums")
        expect(repo[:full_name]).to eq("cmacaulay/advanced-enums")
      end
    end
  end

  describe "#organizations" do
    it "finds all organizations a user belogns to" do
      VCR.use_cassette("#organizations") do
        organizations = user.organizations

        expect(organizations).to be_an(Array)
        expect(organizations.count).to eq(0)
      end
    end
  end
end
