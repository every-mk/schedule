class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  # include ActionController::RequestForgeryProtection

  # def set_csrf_token_header
  #   binding.pry
  #   response.set_header('X-CSRF-Token', form_authenticity_token)
  # end

  # 後で使用するからなくて良い.
  # helper_method :current_user, :user_signed_in?
  # helper_method :current_api_v1_user, :user_signed_in?  # viしなくて良いのか?
end
