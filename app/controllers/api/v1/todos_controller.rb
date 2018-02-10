class Api::V1::TodosController < Api::V1::BaseController
  before_action :request_auth!
  before_action :set_todo, only: [:show, :update, :destroy]

  def index
    @todos = @current_user.todos
  end

  def show
  end

  def create
    @todo = Todo.new(todo_params)
    @todo.user_id = @current_user.id

    if @todo.save
      render :show, status: :created
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  def update
    if @todo.update(todo_params)
      render :show, status: :ok
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @todo.destroy
      render :show, status: :ok
    else
      render json: @todo.errors
    end
  end

  private
    def set_todo
      @todo = @current_user.todos.find(params[:id])
    end

    def todo_params
      params.permit(:title, :list_id, :completed)
    end
end
