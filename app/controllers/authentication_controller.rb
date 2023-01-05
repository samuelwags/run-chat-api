# frozen_string_literal: true

require 'securerandom'

class AuthenticationController < ApplicationController
  include JwtToken

  skip_before_action :authenticate_user, only: [:login]

  def login
    @user = User.find_by_user_name(params[:username])

    if @user&.authenticate(params[:password])

      @user.update!({
        uuid: SecureRandom.uuid,
        signed_in_at: Time.zone.now
      })

      token = encode(@user)

      cookies.signed[:auth_token] = {
        value: token,
        expires: 7.days.from_now,
        httponly: true
      }

      render json: {
        exp: 7.days.from_now,
        status: :ok
      }
    else
      render json: { error: 'unathorized' }, status: 401
    end
  end

  def logout
    @current_user.update!(uuid: SecureRandom.uuid)
    cookies.signed[:auth_token] = {
      value: nil,
      httponly: true
    }
    render json: {
      success: true
    }
  end

  def session
    render json: {
      is_logged_in: true,
      user_name: @current_user.user_name
    }
  end
end
