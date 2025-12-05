require 'json'
require_relative '../http/faraday_adapter'

module Easybroker
    class Client
        def initialize(api_key:, base_url:)
            headers = {
            'X-Authorization' => api_key,
            'Accept' => 'application/json'
            }

            @http = Http::FaradayAdapter.new(base_url: base_url, headers: headers)
        end

        # Endpoint enfocado solo en propiedades
        def get_properties(page:, limit:)
            result = @http.get('/properties', params: { page: page, limit: limit })
            raise "HTTP Error #{result[:status]}" unless result[:status] == 200

            JSON.parse(result[:body])
        end
    end
end

module Easybroker
  class Client
    BASE_URL = "https://api.stagingeb.com"

    def initialize(token)
      @http = Http::FaradayAdapter.new(BASE_URL)
      @token = token
    end

    def get_properties(params = {})
      headers = {
        "Authorization" => "Bearer #{@token}"
      }

      response = @http.get("/v1/properties", params, headers)

      raise "HTTP Error #{response.status}" unless response.success?

      JSON.parse(response.body)
    end
  end
end
