module Api
  module V1
    class UsersController < ApplicationController
      include Pagy::Backend

      # I add this validator just to show specific permissions on the controller
      before_action :verify_authorization, only: [:update, :destroy]

      # GET /users
      def index
        # I use to make Interactors instead of Services, but I want to make the project simpler
        pagy, users = pagy(
          UserService.new(filter_params, nil).index
        )

        render json: paginate_response_with_serializer(pagy, users, UserSerializer)
      end

      # GET /users/:id
      def show
        user = UserService.new(nil, params[:id]).show

        render json: render_response(user, UserSerializer)
      end

      # POST /users/:id
      def create
        user = UserService.new(user_params, nil).create

        render json: render_response(user, UserSerializer)
      end

      # PATCH/PUT /users/:id
      def update
        user = UserService.new(user_params, params[:id]).update

        render json: render_response(user, UserSerializer)
      end

      # DELETE /users/:id
      def destroy
        result = UserService.new(nil, params[:id]).destroy

        render json: { success: result }
      end

      private

      # 'limit' and 'offset' params are used for the pagy gem
      def filter_params
        params.permit(:limit, :offset)
      end

      def user_params
        params.require(:user).permit(:email, :password, :first_name, :last_name)
      end
    end
  end
end
