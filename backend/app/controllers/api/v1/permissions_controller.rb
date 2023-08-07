class Api::V1::PermissionsController < ApplicationController
  def create
    permission = Permission.new(permission_params)

    if permission.save
      render json: { status: 200, data: permission }
    else
      render json: { status: 500, message: "データが不正です" }
    end
  end

  def show
    if Permission.exists?(id: params[:id])
      permission = Permission.find(params[:id])
      render json: { status: 200, data: permission }
    else
      render json: { status: 500, message: "データが存在しません" }
    end
  end

  def update
    if Permission.exists?(id: params[:id])
      permission = Permission.find(params[:id])

      if permission.update(permission_params)
        render json: { status: 200, data: permission }
      else
        render json: { status: 500, message: "データが不正です" }
      end
    else
      render json: { status: 500, message: "データが存在しません" }
    end
  end

  def destroy
    if Permission.exists?(id: params[:id])
      permission = Permission.find(params[:id])
      permission.destroy
      render json: { status: 200, message: "削除しました", data: permission }
    else
      render json: { status: 500, message: "データが存在しません" }
    end
  end

  private

  def permission_params
    params.permit(:group_id, :user_id, :privilege, :join, :post)
  end
end
