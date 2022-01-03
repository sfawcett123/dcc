class Arduino
    include ActiveModel::Model

    def initialize(attributes = {})
      attributes.each do |name, value|
        send("#{name}=", value)
      end
    end

    def persisted?
      false
    end

    class << self
        def all
          return []
        end
    end

end
