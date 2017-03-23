require 'rails_helper'

describe Activity do
  attr_reader :user
  before(:each) do
    @user   = User.create!({username: "cmacaulay",
                       token: ENV['USER_TOKEN']
                     })
  end

  describe "#activity" do
    it "finds all user activity" do
      VCR.use_cassette("#activity") do
        activity = Activity.find_activity(user)

        expect(activity).to be_an(Array)
        expect(activity.count).to eq(30)
      end
    end
  end

  describe "#activity_of_followed" do
    it "finds all activity of followed users" do
      VCR.use_cassette('#follower_activity') do
        activity = Activity.find_activity_of_followed(user, user.following)
        event    = activity.first

        expect(activity).to be_an(Array)
        expect(activity.count).to eq(8)

        expect(event[:type]).to eq("PushEvent")
        expect(event[:actor][:login]).to eq("novohispano")
      end
    end
  end
end
