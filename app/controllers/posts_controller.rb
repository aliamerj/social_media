# post controller
class PostsController < ApplicationController
  before_action :require_login
  # initialize new post object and send to view by @post
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.valid?
      @post.save
      respond_to do |format|
        format.html { redirect_to sites_path, notice: 'Post was successfully created.' }
        format.turbo_stream { flash.now[:notice] = 'Post was successfully created.' }
      end
      send_notification_to_friends(current_user, @post)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:body, :image)
  end
end

