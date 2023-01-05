# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include JwtToken

  skip_forgery_protection

  before_action :authenticate_user

  private

  def auth_token
    cookies.signed[:auth_token]
  end

  def authenticate_user
    @decoded = decode(auth_token)
    @current_user = User.find(@decoded[:uid])
  rescue ActiveRecord::RecordNotFound => e
    render json: { errors: e.message }, status: :unauthorized
  rescue JWT::DecodeError => e
    render json: { errors: e.message }, status: :unauthorized
  end
end
