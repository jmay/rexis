require "spec_helper"
require "rack/test"
require "timecop"

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
      end

      it "codes should not be expired" do
        @item.codes.should_not be_empty
        @item.codes.each do |code|
          code.should_not be_expired
        end
      end

      describe "after code expiration" do
        before do
          Timecop.travel(Time.now + 2 * 60 * 60)
        end

        after do
          Timecop.return
        end

        it "item should still be active" do
          @item.should be_active
        end
        it "code should be expired" do
          @item.codes.each do |code|
            code.should be_expired
          end
        end
      end
    end

    describe "web-activated item" do
      before do
        header "Accept", "application/json"
        get "/at/#{@item.token}"
        h = JSON.parse(last_response.body) rescue {}
        @code = h["code"]
      end

      it "should return code to JSON request" do
        last_response.status.should == 200
        @code.should_not be_nil
      end

      describe "code" do
        it "should map back to the item" do
          item = registry.decode(@code)
          item.should_not be_nil
        end
      end
    end
  end
end
