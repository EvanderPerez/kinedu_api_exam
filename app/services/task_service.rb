class TaskService
  def initialize(user, params, task_id = nil)
    @current_user = user
    @params = params
    @task_id = task_id || params[:id]
    @task =  Task.find(@task_id) if @task_id
  end

  def index
    Task.by_text(@params[:text])
        .by_status(@params[:status])
        .limit(@params[:limit])
        .offset(@params[:offset])
  end

  def show
    @task
  end

  def create
    Task.create(@params)
  end

  def update
    @task.update!(@params)
    @task
  end

  def destroy
    @task.destroy
    @task.destroyed?
  end
end
