module Api
  module V1
    class TasksController < ApplicationController
      # This inclide is for the pagination serializer, some of the methods I picked up are from older projects
      include Pagy::Backend

      # First you need to create an User from /api/v1/users and then log-in on /api/v1/log_in to access on this methods
      before_action :verify_authorization

      # I use to make Interactors instead of Services, but I want to make the project simpler

      # GET /tasks
      def index
        pagy, tasks = pagy(
          TaskService.new(current_user, filter_params, nil).index
        )

        render json: paginate_response_with_serializer(pagy, tasks, TaskSerializer)
      end

      # GET /tasks/:id
      def show
        task = TaskService.new(current_user, nil, params[:id]).show

        render json: render_response(task, TaskSerializer)
      end

      # POST /tasks/:id
      def create
        task = TaskService.new(current_user, task_params, nil).create

        render json: render_response(task, TaskSerializer)
      end

      # PATCH/PUT /tasks/:id
      def update
        task = TaskService.new(current_user, task_params, params[:id]).update

        render json: render_response(task, TaskSerializer)
      end

      # DELETE /tasks/:id
      def destroy
        result = TaskService.new(current_user, nil, params[:id]).destroy

        render json: { success: result }
      end

      private

      # 'limit' and 'offset' params are used for the pagy gem, 'text' and 'status' are for filtering
      def filter_params
        params.permit(:limit, :offset, :text, :status)
      end

      def task_params
        params.require(:task).permit(:name, :description, :status)
      end
    end
  end
end
