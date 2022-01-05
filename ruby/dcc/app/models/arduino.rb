
class Arduino

   include ActiveModel::Model

   @vendorId="0x2341"
   @@_arduinos = []

   def initialize(attributes = {} , list=true )
       attributes.each do |name, value|
           if value.is_a? Hash
             initialize(value , false )
           elsif value.is_a? Array
             value.each do |n|
                 initialize(n , false )
             end
           else
             self.class.send(:attr_accessor, name)
             instance_variable_set( "@#{name}" , value)
           end
      end
      @@_arduinos << self if list
   end

   def persisted?
     false
   end

   class << self
      def boards
        return @@_arduinos.select { |n| n.vid == @vendorId }
      end
      def destroy()
        @@_arduinos = []
      end
   end

end
