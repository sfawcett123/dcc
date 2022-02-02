Dir[Rails.root.join('lib', 'aws' ,'*.rb')].each { |f| require f }

AWS.configure