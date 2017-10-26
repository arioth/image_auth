class Private::UsersController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  before_action :set_user
  http_basic_authenticate_with name: ENV['PRIVATE_USERNAME'], password: ENV['PRIVATE_PASSWORD']

  # POST /private/users/verify_email
  def verify_email
    if @user && @user.image == params[:image]
      AuthMailer.success_auth(@email, request.user_agent).deliver_later
      render json: { message: 'OK' }
    else
      AuthMailer.failed_auth(@email, request.user_agent).deliver_later
      render json: { message: 'No Autorizado' }, status: :unauthorized
    end
  end

  private

  def set_user
    @email = params[:email]
    @user = User.find_by(email: @email)
  end
end