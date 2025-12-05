require_relative 'property'

module Easybroker
    class PropertiesRepository
        def initialize(client:, page_limit:)
            @client = client
            @page_limit = page_limit
        end

        def all
            Enumerator.new do |yielder|
                page = 1

                loop do
                    response = @client.get_properties(page: page, limit: @page_limit)
                    content = response.fetch('content', [])

                    break if content.empty?

                    content.each do |item|
                        yielder << Property.new(item)
                    end

                    total_pages = response.dig('pagination', 'total_pages')
                    break if total_pages && page >= total_pages

                    page += 1
                end
            end
        end

        def titles
            all.map(&:title)
        end
    end
end