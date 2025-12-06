require_relative "../easybroker_client"

module Services
  class PropertiesService
    def initialize
      @client = EasybrokerClient.new
    end

    def list_titles
      data = @client.get_properties

      data["content"].map do |property|
        {
          public_id: property["public_id"],
          title: property["title"]
        }
      end
    end
  end
end
