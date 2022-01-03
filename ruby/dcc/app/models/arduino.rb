
class Arduino

    include ActiveModel::Model

    attr_accessor :name, :port, :matching_boards

    @@_arduinos = []

    def initialize(attributes = {})
      attributes.each do |name, value|
       send("#{name}=", value)
      end
      @@_arduinos << self
    end

    def persisted?
      false
    end
    class << self
      def all
        return @@_arduinos
      end
      def destroy()
        @@_arduinos = []
      end
    end

end
