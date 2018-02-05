class User < ApplicationRecord
  has_secure_password

  def encode_token
    JWT.encode(token_payload, User::secret)
  end

  def self.decode_token(token)
    body = JWT.decode(token, secret)
    HashWithIndifferentAccess.new body[0]
  rescue
    # TODO: learn about proper way of handling errors
  end

  private
    def self.secret
      Rails.application.secrets.secret_key_base
    end

    def token_payload
      exp = 1.hour.from_now.to_i
      { exp: exp, id: id }
    end
end
