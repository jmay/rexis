require "securerandom"

module Rexis
  class Code < Sequel::Model
    plugin :timestamps # using default created_at and updated_at

    def self.create(attributes = {})
      super(attributes.merge(code: generate_code))
    end

    private

    def self.generate_code
      "%06d" % SecureRandom.random_number(1_000_000)
    end
  end
end
