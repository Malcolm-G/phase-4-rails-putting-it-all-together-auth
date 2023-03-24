class ApplicationController < ActionController::API
  include ActionController::Cookies
  before_action :check_login_status

  def app_response(message:'success', status:200, data:nil)
    render json: {
        message: message,
        data: data
    }, status: status
  end

  def user
    User.find(session[:user_id].to_i)
  end

  def check_login_status
    user_id = session[:user_id]
    unless session[:user_id]
      # app_response(message:{errors:'not logged in'}, status: :unauthorized)
      render json:{errors:['not logged in']}, status: :unauthorized
    end
  end
end
