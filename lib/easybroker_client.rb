require "faraday"
require "json"
require "dotenv/load"

class EasybrokerClient
  def initialize
    @api_key = ENV["EASYBROKER_API_KEY"]
    @api_url = ENV["EASYBROKER_API_URL"]

    raise "Missing EASYBROKER_API_KEY" if @api_key.nil?
    raise "Missing EASYBROKER_API_URL" if @api_url.nil?

    @conn = Faraday.new(url: @api_url) do |f|
      f.request :json
      f.response :logger
      f.adapter Faraday.default_adapter
    end
  end

  def get_properties(page: 2, limit: 20)
    response = @conn.get("/v1/properties") do |req|
      req.params["page"] = page
      req.params["limit"] = limit
      req.headers["X-Authorization"] = @api_key
      req.headers["Accept"] = "application/json"
    end

    unless response.status == 200
      puts "\n HTTP ERROR: #{response.status}"
      puts response.body
      raise "Request failed"
    end

    if response.body.nil? || response.body.strip.empty?
      raise "Empty response from API"
    end

    JSON.parse(response.body)
  end
end
