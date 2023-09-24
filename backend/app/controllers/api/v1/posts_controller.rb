class Api::V1::PostsController < ApplicationController
  def create
    post = Post.new(post_params)

    if post.save
      render json: { status: 200, data: post }
    else
      render json: { status: 500, message: "データが不正です" }
    end
  end

  def show
    if Post.exists?(id: params[:id])
      post = Post.find(params[:id])
      render json: { status: 200, data: post }
    else
      render json: { status: 500, message: "データが存在しません" }
    end
  end

  def update
    if Post.exists?(id: params[:id])
      post = Post.find(params[:id])

      if post.update(post_params)
        render json: { status: 200, data: post }
      else
        render json: { status: 500, message: "データが不正です" }
      end
    else
      render json: { status: 500, message: "データが存在しません" }
    end
  end

  def destroy
    if Post.exists?(id: params[:id])
      post = Post.find(params[:id])
      post.destroy
      render json: { status: 200, message: "削除しました", data: post }
    else
      render json: { status: 500, message: "データが存在しません" }
    end
  end

  private

  def post_params
    params.permit(:group_id, :user_id, :content)
  end
end
