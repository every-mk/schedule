class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  # include ActionController::RequestForgeryProtection

  # 後で使用するからなくて良い.
  # helper_method :current_user, :user_signed_in?
  # helper_method :current_api_v1_user, :user_signed_in?  # viしなくて良いのか?
end
