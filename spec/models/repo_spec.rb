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
        starred_repos = user.starred_repos
        starred_repo  = starred_repos.first

        expect(starred_repos.count).to eq(3)

        expect(starred_repo[:name]).to eq("rails_engine")
        expect(starred_repo[:full_name]).to eq("Ryanspink1/rails_engine")
      end
    end
  end
end
