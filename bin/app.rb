$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)


require_relative '../config/settings'
require 'easybroker/client'
require 'easybroker/repository'


client = Easybroker::Client.new(
    api_key: Config::EASYBROKER_API_KEY,
    base_url: Config::EASYBROKER_BASE_URL
)


repo = Easybroker::PropertiesRepository.new(
    client: client,
    page_limit: Config::PAGE_LIMIT
)


puts "=== TÍTULOS DE PROPIEDADES ==="
repo.titles.each do |title|
    puts title
end