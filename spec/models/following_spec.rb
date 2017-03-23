require 'rails_helper'

describe Following do
  attr_reader :user
  before(:each) do
    @user   = User.create!({username: "cmacaulay",
                       token: ENV['USER_TOKEN']
                     })
  end

  describe "#following" do
    it "finds all users who are following a user" do
      VCR.use_cassette("#following") do
        followers = Following.find_following(user)
        follower  = followers.first

        expect(followers).to be_an(Array)
        expect(followers.count).to eq(3)

        expect(follower[:login]).to eq("novohispano")
        expect(follower[:id]).to eq(1654034)
      end
    end
  end

end
