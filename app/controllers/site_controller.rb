# itrepresents home page
class SiteController < ApplicationController
  # showing all post
  # TODO: only for user show the post otherwise show landing page
  def index
    # send the post form db to view by @posts
    @posts = Post.order(created_at: :desc)
  end
end
