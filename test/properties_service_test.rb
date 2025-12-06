require_relative 'test_helper'
require 'json'

class PropertiesServiceTest < Minitest::Test
  def setup
    ENV['EASYBROKER_API_KEY'] = 'test_key'
    ENV['EASYBROKER_API_URL'] = 'https://api.stagingeb.com/v1'
  end

  def test_list_titles
    stub_request(:get, "https://api.stagingeb.com/v1/properties")
      .with(
        query: { page: '1', limit: '20' },
        headers: { 'X-Authorization' => 'test_key' }
      )
      .to_return(
        status: 200,
        body: {
          content: [
            { public_id: 'EB-1', title: 'Test Property 1' },
            { public_id: 'EB-2', title: 'Test Property 2' }
          ]
        }.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )

    service = Services::PropertiesService.new
    result = service.list_titles(page: 1, limit: 20)

    assert_equal 2, result.size
    assert_equal 'EB-1', result.first[:public_id]
    assert_equal 'Test Property 1', result.first[:title]
  end
end
