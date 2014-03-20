module Rexis
  class Registry
    attr_reader :kind

    def initialize(kind:)
      @kind = kind
    end

    def add(url:)
      items.create(kind: kind, url: url)
    end

    def find(args = {})
      items.find(args.merge(kind: kind))
    end

    def decode(code)
      code = Code.filter(code: code).filter("expires_at > current_timestamp").first
      code && code.item
    end

    def count
      items.count
    end

    private
    def items
      Item
    end
  end
end
