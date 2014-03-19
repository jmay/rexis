class Rexis::Registry < Sequel::Model(:registry)
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

  def count
    items.count
  end

  private
  def items
    Rexis::Item
  end
end
