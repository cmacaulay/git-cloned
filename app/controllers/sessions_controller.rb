class SessionsController < ApplicationController
  def create
    client_id     = ENV["GITHUB_CLIENT_ID"]
    client_secret = ENV["GITHUB_SECRET_KEY"]

    @response = Faraday.post("https://github.com/login/oauth/access_token?client_id=#{client_id}&client_secret=#{client_secret}&code=#{params[:code]}")
    access_token = @response.body.split(/\W+/)[1]

    oauth_response = Faraday.get("https://api.github.com/user?access_token=#{access_token}")
    auth           = JSON.parse(oauth_response.body)

    user = User.from_github(auth, access_token)

    if user.save
      session[:user_id] = user.id
      redirect_to dashboard_index_path
    else
      redirect_to root_path
    end
  end

  def destroy
    session.clear

    redirect_to root_path
  end
end
