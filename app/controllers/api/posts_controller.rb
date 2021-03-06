class Api::PostsController < ApplicationController
  before_action :set_post, except: [:index, :create]

  def index
    render json: Post.all
  end

  def show
    render json: @post
  end

  def create
    post = Post.new(post_params)
    if post.save
      render json: post
    else
      render json: { error: "Unsuccessful. Please try again", status: 500 },
      status: 500
    end
  end

  def update
    @post.update(post_params)
    if @post.new_content
      @post.content = @post.content + " " + @post.new_content
    end
    if @post.save
      render json: @post
    else
      render json: { error: "Unsuccessful. Please try again", status: 500 },
      status: 500
    end
  end


  private

  def set_post
    @post = Post.find_by(id: params[:id])
    render json: { error: "Not found" } unless @post
  end

  def post_params
    params.require(:post).permit(:id, :title, :content, :likes, :new_content)
  end
end
