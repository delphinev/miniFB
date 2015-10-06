class UsersController < ApplicationController

  #autocomplete :user, :email, :full => true

  def homepage
    @posts = Post.personal(current_user.id)
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
    @my_friends = User.where(id: current_user.friendships.map{|v| [v.friend_id]})
    @my_friends.each do |f|
      if f.id == @user.id
        @we_are_friends = 1
      end
    end
  end

  def friends
    @user= User.find(params[:id])
    render :json => @user.friends.to_json
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

  def befriend
    @user = User.find(params[:id])
    friendship = Friendship.new
      friendship.user_id = current_user.id
      friendship.friend_id = @user.id
    friendship.save
    #redirect_to "/users/#{@user.id}"
    render :nothing => true, :status => 200
  end

  def unfriend
    @user = User.find(params[:id]).friendships.where(friend_id: current_user.id)
    @user.first.destroy
    #redirect_to "/users/#{current_user.id}"
    render :nothing => true, :status => 200
  end
end
