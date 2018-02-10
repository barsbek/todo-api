class Api::V1::ListsController < Api::V1::BaseController
  before_action :request_auth!
  before_action :set_list, only: [:show, :update, :destroy]

  def index
    @lists = @current_user.lists
  end

  def show
  end

  def create
    @list = List.new(list_params)
    @list.user_id = @current_user.id
    if @list.save
      render :show, status: :created
    else
      render json: @list.errors, status: :unprocessable_entity
    end
  end

  def update
    if @list.update(list_params)
      render :show
    else
      render json: @list.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @list.destroy
    render :show
  end

  private
    def list_params
      params.permit(:title)
    end

    def set_list
      @list = current_user.lists.find(params[:id])
    end
end
