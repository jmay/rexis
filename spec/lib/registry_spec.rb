require "spec_helper"
require "rack/test"

describe Rexis::Registry do
  let :registry do
    @registry ||= Rexis::Registry.new
  end

  describe "a new item" do
    let :created_item do
      registry.add(url: "http://example.com/#{SecureRandom.uuid}")
    end

    it "should be findable" do
      item = registry.find(token: created_item.token)
      item.token.should_not be_nil
      item.should_not be_active
      item.created_at.should_not be_nil
    end

    describe "once activated" do
      before do
        created_item.activate!
      end

      it ".active?" do
        created_item.should be_active
        created_item.codes.count.should == 1
      end
    end
  end
end
