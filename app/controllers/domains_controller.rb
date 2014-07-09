class DomainsController < ApplicationController
    require 'open-uri'
    require 'json'
    require 'openssl'
    require 'i18n'
    require 'net/https'


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
        
        url = URI.parse("https://10.10.0.121")
        url.user = "demo"
        url.password = "changeme"
        
        req = Net::HTTP::Post.new("/broker/rest/domains/tst/applications.json")
        req['Content-Type'] = "application/json"
        req.body = {:name=> params[:domain][:name], 
                    :cartridge => ["mariadb","advanced-ruby"],
                    :aliases => ["www.mudruj.com"],
                    :initial_git_url => "git://github.com/david-strejc/rails-example.git"}.to_json
        
        req.basic_auth url.user, url.password if url.user

        con = Net::HTTP.new(url.host, url.port)
        con.use_ssl = true
        con.verify_mode = OpenSSL::SSL::VERIFY_NONE

        fork do 
            @resp = con.start {|http| 
                    http.read_timeout = 1000
                    http.request(req)}
        end

        #req = Net::HTTP::Post.new("/broker/rest/domains/tst/applications/#{params[:domain][:name]}/aliases.json")
        #req['Content-Type'] = "application/json"
        #req.body = {:id => "#{params[:domain][:name]}.com"}.to_json
        #
        #req.basic_auth url.user, url.password if url.user

        #con = Net::HTTP.new(url.host, url.port)
        #con.use_ssl = true
        #con.verify_mode = OpenSSL::SSL::VERIFY_NONE

        @resp = con.start {|http| 
                http.request(req)}
        
        @domain = Domain.new
        @domain.name = params[:domain][:name]
        @domain.description = params[:domain][:description]

        respond_to do |format|
          if @domain.save
            format.html { redirect_to @domain, notice: 'User was successfully created.' }
            format.js   {}
            format.json { render json: @domain, status: :created, location: @domain }
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

#        url = URI.parse('https://10.10.0.121/broker/rest/domains/tst/applications')
#        url.user = "demo"
#        url.password = "changeme"
#
#        req = Net::HTTP::Post.new(url.path)
#        req.form_data = params1
#        req.basic_auth url.user, url.password if url.user
#        #con = Net::HTTP.new(url.host, url.port)
#        con = Net::HTTP.new(url.host)
#        con.use_ssl = false
#        con.start {|http| http.request(req)}
#uri = URI.parse("https://10.10.0.121/broker/rest/domains/tst/applications?name=hudruj&cartridge=mariadb")
#uri = "https://demo:changeme@10.10.0.121/broker/rest/domains/tst/applications?name=hudruj&cartridge=mariadb"
#uri.user = "demo"
#uri.password = "changeme"
#http =  Net::HTTP.Post.new(uri)
#http.use_ssl = true
#resp = http.start{|http| http.request(req)}
#puts resp.inspect
#req = Net::HTTP::Post.new(uri.host)
#
#puts uri
#puts uri.host
#puts req
#req['X-Parse-Application-Id'] = "abc123"
#req['X-Parse-REST-API-Key'] = "abc123"
#
#req.body = {:data => {:alert => "sup"}, :channels => ["notifications"]}.to_json
#resp = http.start{|http| http.request(req)}
#https://10.10.0.121/broker/rest/domains/tst/applications
#name=boom
#cartridge:='["mariadb","advanced-ruby"]'
#initial_git_url=git://github.com/david-strejc/rails-example.git
