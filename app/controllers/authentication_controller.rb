# frozen_string_literal: true

require 'securerandom'

class AuthenticationController < ApplicationController
  include JwtToken

  skip_before_action :authenticate_user, only: [:login, :create]

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
        httponly: true,
        same_site: :none,
        secure: true
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
      httponly: true,
      same_site: :none,
      secure: true
    }
    render json: {
      success: true
    }
  end

  def create
    key = params[:inviteKey]
    invite = Invite.find_by_key(key)

    if invite.blank?
      return render json: { error: 'Invite does not exist.' }
    end

    if invite.expires.past?
      return render json: { error: 'Invite has expired.' }
    end

    if invite.user_id.present?
      return render json: { error: 'Invite has already been used.' }
    end

    if User.find_by_user_name(params[:username]).present?
      return render json: { error: 'Username is taken.' }
    end

    if params[:password].blank? || params[:password].length < 3
      return render json: { error: 'You need a longer password.' }
    end

    user = User.create(
      user_name: params[:username],
      password: params[:password]
    )
    user.save
    invite.update!(user_id: user.id)
    render json: {
      success: true
    }
  end

  def session
    render json: {
      is_logged_in: true,
      user_name: @current_user.user_name,
      user_id: @current_user.id
    }
  end
end
