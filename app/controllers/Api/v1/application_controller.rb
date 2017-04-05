class Api::V1::ApplicationController < ActionController::Base
  rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found
  # rescue_from ::NameError, with: :error_occurred
  # rescue_from ::ActionController::RoutingError, with: :error_occurred


  def access_token
    params[:access_token] || request.headers["X-Access-Token"]
  end

  def authenticate
    token = self.access_token
    return authentication_error unless token.present?
    @authentication = Authentication.find_by_access_token(token)
    return authentication_error unless @authentication
    @user = @authentication.user
    return authentication_error unless @user
  end


  protected

  def authentication_error
    render Utils.render_json({codeError: 5, message: "Authentication error"}, 401)
    return
  end

  def record_not_found(exception)
    render Utils.render_json({codeError: 404, message: "#{exception.message}"}, 404)
    return
  end

  def error_occurred(exception)
    render Utils.render_json({codeError: 500, message: "Something went wrong:#{exception.message}"}, 500)
    return
  end

end
