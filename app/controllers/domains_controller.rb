class DomainsController < ApplicationController
    require 'open-uri'
    require 'json'
    require 'openssl'
    require 'i18n'

    I18n.enforce_available_locales = true

    I18n.locale = :en
    I18n.default_locale = :en

    OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
    
    def index
        os_url = 'https://10.10.0.121'
        json_data = open("#{os_url}/broker/rest/domains/tst/applications",
                                 :http_basic_authentication=>['demo', 'changeme']).read

        @result = JSON.parse(json_data)

        @domains_data = @result["data"]
    end
   
    def new
        @domain = Domain.new
    end

    def update
        #@domain = params[:domain][:name]
        @domain = params[:domain][:name]
        #@domain = 'hudruj'
    end

end
