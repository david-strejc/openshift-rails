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

        @domains = Domain.all

        @domains_data = @result["data"]
    end
   
    def new
        @domain = Domain.new
    end

    def update 
        @domain = Domain.new
        @domain.name = params[:domain][:name]
        @domain.description = params[:domain][:description]

        respond_to do |format|
          if @domain.save
            #format.html { redirect_to @domain, notice: 'User was successfully created.' }
            format.js   {}
            #format.json { render json: @domain, status: :created, location: @domain }
          else
            format.html { render action: "new" }
            format.json { render json: @domain.errors, status: :unprocessable_entity }
          end
        end      

    end

    def show

    end

    def cartridges
        os_url = 'https://10.10.0.121'
        json_data = open("#{os_url}/broker/rest/cartridges",
                                 :http_basic_authentication=>['demo', 'changeme']).read

        @result = JSON.parse(json_data)
        @cartridge_data = @result["data"]
    end

end
