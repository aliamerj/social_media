# likes controller
class LikesController < ApplicationController
  before_action :require_login
  def create
    @post = Post.find(params[:post_id])
    current_user.like!(@post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    current_user.likes.where(post_id: @post.id).delete_all
  end
end
