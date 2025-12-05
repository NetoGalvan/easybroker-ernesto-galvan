require 'dotenv/load'

module Config
    EASYBROKER_API_KEY = ENV.fetch('EASYBROKER_API_KEY')
    EASYBROKER_BASE_URL = ENV.fetch('EASYBROKER_BASE_URL', 'https://api.stagingeb.com/v1')
    PAGE_LIMIT = Integer(ENV.fetch('PAGE_LIMIT', '20'))
end