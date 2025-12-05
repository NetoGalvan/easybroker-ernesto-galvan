require 'faraday'

module Http
  class FaradayAdapter
    def initialize(base_url)
      @connection = Faraday.new(url: base_url) do |f|
        f.adapter Faraday.default_adapter
      end
    end

    def get(path, params = {}, headers = {})
      @connection.get(path, params, headers)
    end
  end
end