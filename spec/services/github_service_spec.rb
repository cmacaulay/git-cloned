require 'rails_helper'

describe GithubService do
  attr_reader :service

  before(:each) do
    @service = GithubService.new
  end

end 
