class CommentsController < ApplicationController
  before_action :set_post
  attr_reader :post
  
  def index
    redirect_to "/posts/#{post.id}"
  end


  def create
    @comment = Comment.create! content: params[:comment][:content], user: current_user, post: post
    broadcast_comment
    redirect_to "/posts/#{post.id}"
  end

  def new
    @comment = Comment.new
  end

  def show
    @comment = Comment.find_by(id: params[:id])
  end

  def destroy
    comment = Comment.find_by(id: params[:id])
    comment.destroy
    redirect_to "/posts/#{post.id}"
  end

  private
  def set_post
    puts params[:post_id]
    post_id = params[:post_id] || (params[:comment].present? ? params[:comment][:post_id] : nil)
    raise 'Post ID is mandatory' if post_id.nil?
    @post = Post.find_by(:id => post_id)
  end

  def broadcast_comment
    ActionCable.server.broadcast('comments',
        message: @comment.content,
        email: @comment.user.email,
        post_id: post.id)
  end

end
