class SessionsController < ApplicationController
    skip_before_action :check_login_status, only: [:create]

    def create
        user = User.find_by(username:params[:username])
        if user&.authenticate(params[:password])
            session[:user_id] = user.id
            render json: user
        else
            render json: {errors:[user&.errors&.full_messages]},status:401
        end
    end

    def destroy
        session.delete(:user_id)
        head :no_content
    end
end
