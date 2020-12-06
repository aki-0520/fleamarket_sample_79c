class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?

  # before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  #カテゴリー機能
  before_action :set_parents, only: [:new, :create]
  def set_parents
    @parents = Category.where(ancestry: nil)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :email, :password, :first_name, :family_name, :first_name_kana, :family_name_kana, :birth_year_month_day, :send_first_name, :send_family_name, :send_family_name_kana, :send_first_name_kana, :prefecture_code, :post, :city, :address, :apartment, :phone,])
  end
  
  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == Rails.application.credentials[:basic_auth][:user] &&
      password == Rails.application.credentials[:basic_auth][:pass]
    end
  end

  def production?
    Rails.env.production?
  end
end
