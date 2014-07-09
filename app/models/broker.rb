require 'active_resource' 
require 'openssl'

class Broker < ActiveResource::Base
    self.site = "https://10.10.0.121/"
    self.user = "demo"
    self.password = "changeme"
    #self.ssl_options = { :verify_mode  => OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE }
end
