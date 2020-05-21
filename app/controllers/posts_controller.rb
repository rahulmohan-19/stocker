class PostsController < ApplicationController
  attr_reader :post

  def index
    Rails.logger.debug "current_user #{current_user}"
    @posts = Post.all
  end

  def create
    @post = Post.create! content: params[:post][:content], title: params[:post][:content], user: current_user
    notify_new_post
    redirect_to '/posts'
  end

  def new
    @post = Post.new
  end


  def show
    Rails.logger.debug "current_user #{current_user.inspect}"
    set_post
    @show_delete = (@post.user.email == current_user.email)
  end

  def destroy
    set_post
    post.destroy
    redirect_to '/posts'
  end


  private
  def set_post
    post_id = params[:id]
    raise 'Post ID is mandatory' if post_id.nil?
    @post = Post.includes(:comments,:user).find_by(id: post_id)
    raise 'Post not found error' unless @post.present? #handle gracefully
  end

  def notify_new_post
        ActionCable.server.broadcast 'notifications',
        title: @post.title,
        email: @post.user.email,
        content: @post.content,
        post_id: @post.id
  end
end
