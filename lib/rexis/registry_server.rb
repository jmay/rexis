require "sinatra/base"
require "json"
require "haml"

class Rexis::Server < Sinatra::Base
  attr_reader :registry, :domain

  configure do
    enable :logging
    enable :dump_errors
    enable :raise_errors
    disable :show_exceptions # show_exceptions generates HTML, not useful for API
  end

  before do
    content_type 'application/json'
  end

  def initialize(options = {})
    super
    @registry = options.fetch(:registry)
    @domain = options.fetch(:domain)
  end

  # get "/?" do
  #   result = {count: registry.count}
  #   json result
  # end

  post '/?' do
    url = requires_url
    item = registry.add(url: url)
    result = {registry_url: url_for(item)}
    json result
  end

  get '/at/:token' do
    if item = registry.find(token: params[:token])
      code = item.activate!
      display_code(code)
    else
      bad_token
    end
  end

  get '/for/:code' do
    if item = registry.find(code: params[:code])
      result = {url: item.url}
      result.to_json
    else
      bad_code
    end
  end

  private

  def json(data)
    JSON.pretty_generate(data)
  end

  def json_request?
    request.accept.first.to_s =~ /json/
  end

  def requires_url
    params[:url] or
      halt 422, json({error: "missing url parameter"})
  end

  def bad_token
    status 401
    if json_request?
      json(error: "Invalid token")
    else
      content_type :html
      haml :subscribe_error
    end
  end

  def bad_code
    halt 401, json({error: "Bad code"})
  end

  def display_code(code)
    if json_request?
      json(code: code)
    else
      # this is a browser
      content_type :html
      haml :subscribe, locals: {code: code}
    end
  end

  def url_for(item)
    "#{domain}/#{registry.kind}/at/#{item.token}"
  end
end
