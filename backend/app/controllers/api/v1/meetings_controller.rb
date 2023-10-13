class Api::V1::MeetingsController < ApplicationController
  def create
    meeting = Meeting.new(meeting_params)

    if meeting.save
      render json: { status: 200, data: meeting }
    else
      render json: { status: 500, message: "データが不正です" }
    end
  end

  def show
    if Meeting.exists?(id: params[:id])
      meeting = Meeting.find(params[:id])
      render json: { status: 200, data: meeting }
    else
      render json: { status: 500, message: "データが存在しません" }
    end
  end

  def update
    if Meeting.exists?(id: params[:id])
      meeting = Meeting.find(params[:id])

      if meeting.update(meeting_params)
        render json: { status: 200, data: meeting }
      else
        render json: { status: 500, message: "データが不正です" }
      end
    else
      render json: { status: 500, message: "データが存在しません" }
    end
  end

  def destroy
    if Meeting.exists?(id: params[:id])
      meeting = Meeting.find(params[:id])
      meeting.destroy
      render json: { status: 200, message: "削除しました", data: meeting }
    else
      render json: { status: 500, message: "データが存在しません" }
    end
  end

  private

  def meeting_params
    params.permit(:meeting_id, :group_id, :name, :priority, :start_at, :end_at, :notice_period, :content)
  end
end
