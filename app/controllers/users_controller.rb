class UsersController < ApplicationController
    skip_before_action :check_login_status, only: [:create]

    def create
        user = User.create(user_params)
        if user.valid?
            session[:user_id] = user.id
            render json: user, status: :created
        else
            render json:{errors:user.errors.full_messages}, status:422
        end
    end

    def show
        user = User.find(session[:user_id])
        if user
            render json: user, status: :created
        else
            render json:{message:'something went wrong'}, status: :unauthorized
        end
    end

    private
    def user_params
        params.permit(:username, :image_url, :bio, :password, :password_confirmation)
    end
end
