require_relative 'test_helper'
require 'easybroker/client'
require 'easybroker/repository'


class PropertiesRepositoryTest < Minitest::Test
    SAMPLE_PAGE_1 = {
        'content' => [
        { 'id' => 1, 'title' => 'Casa 1' },
        { 'id' => 2, 'title' => 'Casa 2' }
        ],
        'pagination' => { 'total_pages' => 2 }
    }

    SAMPLE_PAGE_2 = {
        'content' => [
        { 'id' => 3, 'title' => 'Casa 3' }
        ],
        'pagination' => { 'total_pages' => 2 }
    }

    def setup
        base = 'https://api.stagingeb.com/v1'

        stub_request(:get, /#{base}\/properties/)
        .to_return({ status: 200, body: SAMPLE_PAGE_1.to_json }, { status: 200, body: SAMPLE_PAGE_2.to_json })

        client = Easybroker::Client.new(api_key: 'fake', base_url: base)
        @repo = Easybroker::PropertiesRepository.new(client: client, page_limit: 2)
    end


    def test_titles
        titles = @repo.titles
        assert_equal ['Casa 1', 'Casa 2', 'Casa 3'], titles
    end
end