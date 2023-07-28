class ApplicationController < ActionController::API
# class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ActionController::RequestForgeryProtection

  def set_csrf_token_header
    response.set_header('X-CSRF-Token', form_authenticity_token)
  end

  # 後で使用するからなくて良い.
  helper_method :current_user, :user_signed_in?
#   helper_method :current_api_v1_user, :user_signed_in?  # viしなくて良いのか?
end
