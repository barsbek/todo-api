class User < ApplicationRecord
  has_secure_token
  has_secure_password

  def encode_token
    JWT.encode(token_payload, secret)
  end

  def decode_token(token)
    JWT.decode(token, secret)
  end

  private
    def secret
      Rails.application.secrets.secret_key_base
    end

    def token_payload
      exp = 1.minute.from_now.to_i
      { exp: exp, id: id }
    end
end
