class TasksController < ApplicationController
  include Pagy::Backend

  # GET /tasks
  def index
    pagy, tasks = pagy(
      TaskService.new(nil, filter_params).get_all
    )

    render json: paginate_response_with_serializer(pagy, tasks, TaskSerializer)
  end

  # GET /tasks/:id
  def show
    render json: @task
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)

    if @task.save
      render json: @task, status: :created, location: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tasks/1
  def update
    if @task.update(task_params)
      render json: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy
  end

  private

  def filter_params
    params.permit(:limit, :offset, :text, :status)
  end

  def task_params
    params.require(:task).permit(:name, :description)
  end
end
