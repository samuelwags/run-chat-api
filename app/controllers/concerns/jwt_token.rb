# frozen_string_literal: true

module JwtToken
  extend ActiveSupport::Concern

  SECRET_KEY = Rails.application.credentials.secret_key_base

  def encode(user, exp: 7.days.from_now)
    payload = {
      'uid': user.id,
      'uuid': user.uuid,
      'expiry': exp
    }

    JWT.encode(payload, SECRET_KEY)
  end

  def decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new decoded
  end
end
