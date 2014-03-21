module Rexis
  class Registry
    def add(url:)
      items.create(url: url)
    end

    def find(args)
      items.find(args)
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
