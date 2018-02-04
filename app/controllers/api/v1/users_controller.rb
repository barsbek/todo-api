class Api::V1::UsersController < Api::V1::BaseController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render status: :created
    else
      # move errors into view
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def authenticate
    @user = User.find_by_email(user_params[:email])
    if @user
      if @user.authenticate(user_params[:password])
        render json: @user.token
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    else
      render json: { message: "User is not found" }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
