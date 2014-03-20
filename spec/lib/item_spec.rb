require "spec_helper"
require "rack/test"

describe Rexis::Item do
  include Rack::Test::Methods
  def registry
    @registry ||= Rexis::Registry.new(kind: "items")
  end
  def app
    Rexis::Server.new(
      registry: registry,
      domain: ENV["REGISTRY_DOMAIN"]
      )
  end

  describe "unregistered item" do
    it ".find" do
      registry.find(token: "DOES-NOT-EXIST").should == nil
    end

    it "should give Access Denied error" do
      get "/at/BOGUS"
      last_response.status.should == 401
    end
  end

  describe "registered item" do
    before do
      url = "http://example.com/#{SecureRandom.uuid}"
      @item = registry.add(url: url)
    end

    it "should initially be inactive" do
      @item.should_not be_active
      @item.codes.should be_empty
    end

    describe "activated item" do
      before do
        @item.activate!
      end

      it "should be active" do
        @item.should be_active
        @item.codes.should_not be_empty
      end
    end

    describe "web-activated item" do
      before do
        header "Accept", "application/json"
        get "/at/#{@item.token}"
      end

      it "should return code to JSON request" do
        last_response.status.should == 200
        h = JSON.parse(last_response.body)
        h["code"].should_not be_nil
      end
    end
  end
end
