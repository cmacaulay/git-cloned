require 'rails_helper'

describe Repo do
  attr_reader :user
  before(:each) do
    @user   = User.create!({username: "cmacaulay",
                       token: ENV['USER_TOKEN']
                     })
  end

  describe "#find_starred_repos" do
    it "finds all of the user's starred repos" do
      VCR.use_cassette("#starred_repos") do
        starred_repos = Repo.find_starred(user)
        starred_repo  = starred_repos.first

        expect(starred_repos.count).to eq(3)

        expect(starred_repo[:name]).to eq("rails_engine")
        expect(starred_repo[:full_name]).to eq("Ryanspink1/rails_engine")
      end
    end
  end

  describe "#repos" do
    it "finds all repos that belong to user" do
      VCR.use_cassette("#repos") do
        repos = Repo.find_repos(user)
        repo  = repos.first

        expect(repos).to be_an(Array)
        expect(repos.count).to eq(30)

        expect(repo[:id]).to eq(78127608)
        expect(repo[:name]).to eq("advanced-enums")
        expect(repo[:full_name]).to eq("cmacaulay/advanced-enums")
      end
    end
  end
end
