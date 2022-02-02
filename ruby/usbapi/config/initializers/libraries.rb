Dir[Rails.root.join('lib', 'usb' ,'*.rb')].each { |f| require f }
Dir[Rails.root.join('lib', 'aws' ,'*.rb')].each { |f| require f }