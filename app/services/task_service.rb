class TaskService
  def initialize(user, params)
    @current_user = user
    @params = params
  end

  def get_all
    Task.by_text(@params[:text])
        .by_status(@params[:status])
        .limit(@params[:limit])
        .offset(@params[:offset])
  end
end
