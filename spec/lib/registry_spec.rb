require "spec_helper"
require "rack/test"

describe Rexis::Registry do
  let :registry do
    @registry ||= Rexis::Registry.new(kind: "items")
  end

  describe "with an item" do
    let :created_item do
      @item ||= registry.add(url: "http://example.com/#{SecureRandom.uuid}")
    end

    it "should be findable" do
      item = registry.find(token: created_item.token)
      item.should_not be_nil
      item.token.should_not be_nil
      item.created_at.should_not be_nil
      item.code.should be_nil
    end
  end

  describe "with an activated item" do
    let :item do
      item = registry.add(url: "http://example.com/#{SecureRandom.uuid}")
      item.ping
      item
    end

    it "should be ready to activate" do
      item.code.should_not be_nil
    end
  end
end
