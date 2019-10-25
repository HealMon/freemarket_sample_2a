class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?
  # before_action :after_sign_in_path_for, if: :devise_controller?, only: :create
  protect_from_forgery with: :exception

  private
  # def after_sign_in_path_for(resource)
    # if (session[:previous_url] == root_path)
    #   super
    # else
      # session[:previous_url] = root_path
      # super
    # end
  # end

  def production?
    Rails.env.production?
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end
end
