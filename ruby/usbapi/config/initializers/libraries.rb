Dir[Rails.root.join('lib', 'usb' , '*.rb')].each { |f| require f }
