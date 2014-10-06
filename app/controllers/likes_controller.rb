class LikesController < ApplicationController
  include ActionView::Helpers::TextHelper
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @post.likes.create
    render json: { new_like_count: "#{pluralize(@post.likes.count, "like")}"}
  end
end
