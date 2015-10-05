class UsersController < ApplicationController

  autocomplete :user, :email, :full => true

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
    @posts = Post.where(friend_id: @user.id)
  end

  def create
    @user = User.find(params[:id])
    @post = Post.new
      @post.content = params[:content]
      @post.user_id = current_user.id
      @post.friend_id = @user.id
    @post.save
    redirect_to "/users/#{@user.id}"
  end
end
