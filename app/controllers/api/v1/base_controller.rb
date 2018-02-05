class Api::V1::BaseController < ActionController::API
  def request_auth!
    unless current_user
      response = { message: "User is not authorized" }
      render json: response, state: :unauthorized
    end
  end

  private
    def current_user
      payload = User.decode_token(params[:token])
      @current_user ||= User.find_by_id(payload[:id]) if payload
    rescue
    end
end
