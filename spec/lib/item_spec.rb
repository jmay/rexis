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

  it "should not find unregistered item" do
    get "/at/BOGUS"
    last_response.status.should == 401
  end

  it "should find registered item" do
    url = "http://example.com/#{SecureRandom.uuid}"
    # item1 = registry.items.create(kind: 'items', url: url)
    item1 = registry.add(url: url)
    token = item1.token
    header "Accept", "application/json"
    get "/at/#{token}"
    last_response.status.should == 200
    # item2 = registry.items.find(kind: 'items', token: token)
    item2 = registry.find(token: token)
    expected_response = {'code' => item2.code}
    JSON.parse(last_response.body).should == expected_response
    item2.id.should == item1.id
  end
end
