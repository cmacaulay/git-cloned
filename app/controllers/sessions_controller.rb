class SessionsController < ApplicationController
  def create
    github_oauth = GithubOauth.new(params[:code])
    access_token = github_oauth.access_token
    auth         = github_oauth.data

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
