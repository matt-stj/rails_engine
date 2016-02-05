class UsersController < ApplicationController

  def show
    if session[:user_id]
      @user = User.find(session[:user_id])
    end
  end
end
