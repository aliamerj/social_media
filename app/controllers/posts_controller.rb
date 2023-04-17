
class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.valid?
      @post.save
      respond_to do |format|
        format.html { redirect_to posts_new_path, notice: 'Post was successfully created.' }
        format.turbo_stream { render turbo_stream: turbo_stream.prepend("posts", partial: "post", locals: { post: @post }) }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end
end
