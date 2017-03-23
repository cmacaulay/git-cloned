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
end
