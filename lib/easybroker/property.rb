module Easybroker
    class Property
        attr_reader :id, :title

        def initialize(data)
            @id = data['id']
            @title = data['title'] || data['name'] || 'Sin título'
        end
    end
end