class ApplicationController < ActionController::API
   include AgeGroupAuthorization
   include OrganizationAuthorization
   # include Pundit
	SECRET = ENV['JWT_SECRET'] || 'your_secret_key'

  def encode_user_data(payload)
    JWT.encode(payload, SECRET, 'HS256')
  end

  def decode_user_data(token)
    JWT.decode(token, SECRET, true, algorithm: 'HS256')
  rescue JWT::DecodeError => e
    Rails.logger.error "JWT Decode Error: #{e.message}"
    nil
  end

  def authentication
    header = request.headers['token']
    token = header.split(' ').last if header
    decoded = decode_user_data(token)

    if decoded
      user_id = decoded[0]['user_id']
      @current_user = Account.find_by(id: user_id)
    end

    render json: { message: 'Unauthorized' }, status: :unauthorized unless @current_user
  end
  def current_user
    @current_user
  end

  # Add this if you want to rescue unauthorized errors globally
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # private

  # def user_not_authorized(exception)
  #   render json: { error: "you can not have  access: #{exception.policy.class} #{exception.query}" }, status: :forbidden
  # end
end