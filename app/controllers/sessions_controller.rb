class SessionsController < ApplicationController
  def create
    client_id     = '919138390dcec0da95d3'
    client_secret = '370627700c5ef6cda3a90463e6a536315de748f7'

    @response = Faraday.post("https://github.com/login/oauth/access_token?client_id=#{client_id}&client_secret=#{client_secret}&code=#{params[:code]}")
    access_token = @response.body.split(/\W+/)[1]

    oauth_response = Faraday.get("https://api.github.com/user?access_token=#{access_token}")
    auth           = JSON.parse(oauth_response.body)

    user = User.find_or_create_by(uid: auth["id"], provider: 'github')
    user.username   = auth["login"]
    user.name       = auth["name"]
    user.uid        = auth["id"]
    user.avatar     = auth["avatar_url"]
    user.starred    = auth["starred_url"]
    user.followers  = auth["followers_url"]
    user.following  = auth["following_url"]
    user.token      = access_token
    user.save

    session[:user_id] = user.id
    redirect_to dashboard_index_path
  end
end
