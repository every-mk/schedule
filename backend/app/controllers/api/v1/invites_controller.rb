class Api::V1::InvitesController < ApplicationController
  def create
    invite = Invite.new(invite_params)

    if invite.save
      render json: { status: 200, data: invite }
    else
      render json: { status: 500, message: "データが不正です" }
    end
  end

  def show
    if Invite.exists?(id: params[:id])
      invite = Invite.find(params[:id])
      render json: { status: 200, data: invite }
    else
      render json: { status: 500, message: "データが存在しません" }
    end
  end

  def update
    if Invite.exists?(id: params[:id])
      invite = Invite.find(params[:id])

      if invite.update(invite_params)
        render json: { status: 200, data: invite }
      else
        render json: { status: 500, message: "データが不正です" }
      end
    else
      render json: { status: 500, message: "データが存在しません" }
    end
  end

  def destroy
    if Invite.exists?(id: params[:id])
      invite = Invite.find(params[:id])
      invite.destroy
      render json: { status: 200, message: "削除しました", data: invite }
    else
      render json: { status: 500, message: "データが存在しません" }
    end
  end

  private

  def invite_params
    params.permit(:invite_id, :meating_id, :user_id, :kind)
  end
end
