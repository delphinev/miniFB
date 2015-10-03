class UsersController < ApplicationController

  def homepage
  end

  
  def start
    if current_user
      redirect_to '/homepage'
    else
      redirect_to new_user_session_path
    end
  end

  def index
  	@users= User.all
  end

  def show
  	@user= User.find(params[:id])
  end
end
