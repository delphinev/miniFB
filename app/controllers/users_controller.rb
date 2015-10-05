class UsersController < ApplicationController

 autocomplete :user, :email, :full => true


  def bienvenue
  
  end

  
  def start
    if current_user
      redirect_to '/bienvenue'
    else
      redirect_to new_user_session_path
    end
  end

end
