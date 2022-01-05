class Arduino

   include ActiveModel::Model

   @vendorId="0x2341"
   @@_arduinos = []
   @sp = nil

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

   def open
      baud_rate = 9600
      data_bits = 8
      stop_bits = 1
      parity = SerialPort::NONE

      @sp = SerialPort.new(@address, baud_rate, data_bits, stop_bits, parity)
   end

   def read
     self.open if !@sp 
     @sp.gets
   end

   def write
    puts "Steev"
   end

   def persisted?
     false
   end

   class << self
      def boards
        begin
           return @@_arduinos.select { |n| n.vid == @vendorId } 
        rescue 
           return []
        end      
      end
      def destroy()
        @@_arduinos = []
      end
   end

end
