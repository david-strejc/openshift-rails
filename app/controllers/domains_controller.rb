class DomainsController < ApplicationController
    require 'open-uri'
    require 'json'
    require 'openssl'

    OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
    
    def index
        os_url = 'https://10.10.0.121'
        json_data = open("#{os_url}/broker/rest/domains/tst/applications",
                                 :http_basic_authentication=>['demo', 'changeme']).read

        result = JSON.parse(json_data)

        @app_urls = result["data"]
    end

    def new
    end

end
