class Public::UsersController < ActionController::API
  def login
    begin
      RestClient::Request.new(
        method: :post,
        url: "#{request.base_url}/private/users/verify_email?email=#{params[:email]}",
        user: ENV['PRIVATE_USERNAME'],
        password: ENV['PRIVATE_PASSWORD'],
        payload: {
          image: params[:image]
        },
        headers: {
          'User-Agent' => request.user_agent
        }
      ).execute
      render json: { message: 'OK' }
    rescue RestClient::ExceptionWithResponse => _e
      render json: { message: 'No Autorizado' }, status: :unauthorized
    end
  end
end