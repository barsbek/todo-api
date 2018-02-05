class Api::V1::BaseController < ActionController::API
  def request_auth!
    unless current_user
      response = { message: "User is not authorized" }
      render json: response, state: :unauthorized
    end
  end

  private
    def current_user
      payload = User.decode_token(token)
      @current_user ||= User.find_by_id(payload[:id]) if payload
    rescue
    end

    def token
      auth = request.headers['Authorization']
      auth.split(' ').last if auth.present?
    end
end
