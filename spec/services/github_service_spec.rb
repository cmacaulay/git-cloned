require 'rails_helper'

describe GithubService do
  attr_reader :service, :user

  before(:each) do
    @user    = User.create!({username: "cmacaulay",
                       token: ENV['USER_TOKEN']
                     })
    @service = GithubService.new(user)
  end

  describe '#starred_repos' do
    it 'finds all starred repos' do
      VCR.use_cassette("#starred_repos") do
        starred_repos = service.starred_repos(user)
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
        followers = service.followers(user)
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
        followers = service.following(user)
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
        repos = service.repos(user)
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
    it "finds all organizations a user belongs to" do
      VCR.use_cassette("#organizations") do
        organizations = service.organizations(user)

        expect(organizations).to be_an(Array)
        expect(organizations.count).to eq(0)
      end
    end
  end

  describe "#activity" do
    it "finds all user activity" do
      VCR.use_cassette("#activity") do
        activity = service.activity(user)

        expect(activity).to be_an(Array)
        expect(activity.count).to eq(30)
      end
    end
  end

  describe "#activity_of_followed" do
    it "finds all activity of followed users" do
      VCR.use_cassette('#follower_activity') do
        activity = service.activity_of_followed(user, user.following)
        event    = activity.first

        expect(activity).to be_an(Array)
        expect(activity.count).to eq(8)

        expect(event[:type]).to eq("PushEvent")
        expect(event[:actor][:login]).to eq("novohispano")
      end
    end
  end
end
