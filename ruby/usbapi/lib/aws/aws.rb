require 'aws-sdk-secretsmanager'
require 'json'

class AWS

  PREFIX = "DCC_"

  class << self
    
    def configure 
      if ENV['AWS_REGION'] && ENV['AWS_SECRET_ARN']
          client = Aws::SecretsManager::Client.new(region: ENV['AWS_REGION'])
          get_secret_value_response = client.get_secret_value(secret_id: ENV['AWS_SECRET_ARN'] )
          secret = get_secret_value_response.secret_string
          JSON.parse(secret).keys.each do | k |
            fk = "#{PREFIX}#{k.upcase}"
            ENV[ fk ] =  JSON.parse(secret)[k].to_s
          end
          puts "Secrets will be loaded from AWS."
      elsif !ENV['AWS_SECRET_ARN']
        puts "AWS_SECRET_ARN has been set. Secrets will not be loaded from AWS."      
      elsif !ENV['AWS_REGION']
        puts "AWS_REGION not set. Secrets will not be loaded from AWS."
      end
    end
  
  end

end
