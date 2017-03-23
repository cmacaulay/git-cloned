require 'rails_helper'

describe Organization do
  attr_reader :user
  before(:each) do
    @user   = User.create!({username: "cmacaulay",
                       token: ENV['USER_TOKEN']
                     })
  end

  describe "#organizations" do
    it "finds all organizations a user belogns to" do
      VCR.use_cassette("#organizations") do
        organizations = Organization.find_organizations(user)

        expect(organizations).to be_an(Array)
        expect(organizations.count).to eq(0)
      end
    end
  end
end
