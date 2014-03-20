require "securerandom"

module Rexis
  class Code < Sequel::Model
    plugin :timestamps, create: :created_at, update: nil
    many_to_one :item

    DEFAULT_EXPIRATION = 1 * 60 * 60 # 1 hour

    def self.create(expiration: DEFAULT_EXPIRATION)
      super(code: generate_code, expires_at: Time.now + expiration)
    end

    def chars
      code.chars
    end

    def expired?
      Time.now > expires_at
    end

    private

    def self.generate_code
      "%06d" % SecureRandom.random_number(1_000_000)
    end
  end
end
