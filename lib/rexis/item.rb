require "securerandom"

module Rexis
  class Item < Sequel::Model(:registry)
    plugin :timestamps
    one_to_many :codes

    def self.create(attributes)
      super(attributes.merge(token: generate_token))
    end

    # def pinged?
    def active?
      codes.any?
    end

    def activate!
      code = Code.create(expiration: ENV['REXIS_CODE_EXPIRATION'].to_i)
      add_code(code)
      code
    end

    private

    def self.generate_token
      SecureRandom.uuid
    end

    def generate_code
      "%06d" % SecureRandom.random_number(1_000_000)
    end
  end
end
