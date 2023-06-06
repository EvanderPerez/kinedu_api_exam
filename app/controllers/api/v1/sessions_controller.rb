module Api
  module V1
    class SessionsController < ApplicationController
      def create
        @user = User.find_by(email: params[:email])
        if @user&.authenticate(params[:password])
          @user.change_token
          save_session(@user)
          @current_user = @user
          render json:  "user_id = #{@current_user.id} access_token: #{@current_user.access_token}"
        else
          # I can use I18n gem for make an internationalizated message
          render json:  'Usuario no encontrado'
        end
      end

      private

      def save_session(user)
        session[:session_token] = user.access_token
        session[:session_id] = user.id
      end
    end
  end
end
