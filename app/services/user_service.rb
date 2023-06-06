class UserService
  def initialize(params, user_id = nil)
    @params = params
    @user_id = user_id || params[:id]
    @user = User.find_by(id: @user_id) if @user_id
  end

  def index
    User.all
  end

  def show
    @user
  end

  def create
    user = User.create(@params)
    user
  end

  def update
    @user.update!(@params)
    @user
  end

  def destroy
    @task.destroy
    @task.destroyed?
  end
end
