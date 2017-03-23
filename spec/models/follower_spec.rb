require 'rails_helper'

describe Follower do
  attr_reader :user
  before(:each) do
    @user   = User.create!({username: "cmacaulay",
                       token: ENV['USER_TOKEN']
                     })
  end

  describe "#followers" do
    it "finds all users who follow a user" do
      VCR.use_cassette("#followers") do
        followers = Follower.find_followers(user)
        follower  = followers.first

        expect(followers).to be_an(Array)
        expect(followers.count).to eq(1)

        expect(follower[:login]).to eq("meyerhoferc")
      end
    end
  end
end
