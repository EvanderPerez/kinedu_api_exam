class TaskService
  def initialize(user, params)
    @current_user = user
    @params = params
  end

  def index
    Task.by_text(@params[:text])
        .by_status(@params[:status])
        .limit(@params[:limit])
        .offset(@params[:offset])
  end

  def show
    Task.find(@params[:id])
  end

  def create
    Task.create(@params)
  end
end
