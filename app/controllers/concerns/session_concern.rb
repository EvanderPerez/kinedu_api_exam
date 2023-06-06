module SessionConcern
  def current_user
    # I use request.headers to call them from Postman 'Access-Token' and 'User-Id' headers
    @current_user ||= User.find_by(id: request.headers['HTTP_USER_ID'], access_token: request.headers['HTTP_ACCESS_TOKEN'])
  end

  def is_signed_in?
    !current_user.nil?
  end

  def verify_authorization
    # I can use I18n gem for make an internationalizated message
    render json: 'Necesita iniciar sesión', status: :unauthorized unless is_signed_in?
  end
end
