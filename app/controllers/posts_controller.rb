class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :set_post, only: [:destroy]
  before_action :authorize_user, only: [:destroy]

  def index
    query = params[:q]
  	@post = Post.new
  	@comment = Comment.new
    if (query.blank?)
      @posts = Post.all
    else
  	 @posts = Post.where('content like ?', ('%' + query + '%')).reverse()
    end
    @users=User.all
    @user=current_user
    friend_obj=Friendship.new
    @all_req_user=friend_obj.all_requests_user(current_user)
    @all_u_frnds=friend_obj.all_user_requested_friends(current_user)
    @all_i_frnds=friend_obj.all_user_accepted_friends(current_user)
    @all_my_req=friend_obj.all_requests_by_user(current_user)
    @n_elg_frnds=friend_obj.all_non_eligible_friends(current_user)
    return @posts
  end

  def create
  	@post = Post.new(post_params)
  	@post.user = current_user
  	@post.save
  	@comment = Comment.new
  end

  def destroy
    @post_id = @post.id
  	@post.destroy
  	
  end

  private

  def post_params
  	params.require(:post).permit(:content)
  end

  def set_post
  	@post = Post.find(params[:id])
  end

  def authorize_user
  	if @post.user != current_user
  		return redirect_to root_path
  	end
  	return true

  end

end











