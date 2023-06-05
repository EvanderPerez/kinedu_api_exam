class TasksController < ApplicationController
  include Pagy::Backend

  # GET /tasks
  def index
    pagy, tasks = pagy(
      TaskService.new(nil, filter_params, nil).index
    )

    render json: paginate_response_with_serializer(pagy, tasks, TaskSerializer)
  end

  # GET /tasks/:id
  def show
    task = TaskService.new(nil, nil, params[:id]).show

    render json: task, serializer: TaskSerializer
  end

  # POST /tasks/:id
  def create
    task = TaskService.new(nil, task_params, nil).create

    render json: task, serializer: TaskSerializer
  end

  # PATCH/PUT /tasks/1
  def update
    task = TaskService.new(nil, task_params, params[:id]).update

    render json: task, serializer: TaskSerializer
  end

  # DELETE /tasks/1
  def destroy
    result = TaskService.new(nil, nil, params[:id]).destroy

    render json: { success: result }
  end

  private

  def filter_params
    params.permit(:limit, :offset, :text, :status)
  end

  def task_params
    params.require(:task).permit(:name, :description, :status)
  end
end
