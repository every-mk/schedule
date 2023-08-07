class Api::V1::GroupsController < ApplicationController
  def create
    group = Group.new(group_params)

    if group.save
      render json: { status: 200, data: group }
    else
      render json: { status: 500, message: "データが不正です" }
    end
  end

  def show
    if Group.exists?(id: params[:id])
      group = Group.find(params[:id])
      render json: { status: 200, data: group }
    else
      render json: { status: 500, message: "データが存在しません" }
    end
  end

  def update
    if Group.exists?(id: params[:id])
      group = Group.find(params[:id])

      if group.update(group_params)
        render json: { status: 200, data: group }
      else
        render json: { status: 500, message: "データが不正です" }
      end
    else
      render json: { status: 500, message: "データが存在しません" }
    end
  end

  def destroy
    if Group.exists?(id: params[:id])
      group = Group.find(params[:id])
      group.destroy
      render json: { status: 200, message: "削除しました", data: group }
    else
      render json: { status: 500, message: "データが存在しません" }
    end
  end

  private

  def group_params
    params.permit(:space, :name, :content)
  end
end
