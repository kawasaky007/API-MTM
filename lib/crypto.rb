# frozen_string_literal: true

module Crypto
  def self.generate_code
    rand(111_111..999_999).to_s
  end

  def self.expired_code?(user)
    return user.updated_at + CONST::AUTH_CODE_EXP < Time.zone.now
  end

  def self.generate_token(user)
    JsonWebToken.encode(
      from: user.class.singular_name,
      uuid: user.id,
      auth_code: user.auth_code
    )
  end

  class JsonWebToken
    def self.encode(payload, exp = CONST::DEFAULT_EXP_TIME.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, CONST::SECRET_KEY)
    end

    def self.decode(token)
      decoded_token = JWT.decode(token, CONST::SECRET_KEY)[0]
      HashWithIndifferentAccess.new decoded_token
    end
  end
end
