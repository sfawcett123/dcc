class Arduino

   include ActiveModel::Model

   @vendorId="0x2341"
   @sp = nil

   def initialize(attributes = {} )
      @redis = Redis.new(host: "localhost")
      @logger = Rails.logger
      data = Marshal.dump( attributes )
      @redis.lpush "arduinos" , data
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
           rVal = [] 
           logger = Rails.logger
           redis = Redis.new(host: "localhost")

           logger.info "Fetching list of arduinos from Redis"
           data = redis.lrange( "arduinos", 0, -1 )
           data.each do | row | 
                popped_row = Marshal.load( row )
                rVal << JSON.parse( popped_row.to_json )
           end
           logger.debug "Redis returns #{rVal}"
           return  rVal
      end

      def destroy()
           redis = Redis.new(host: "localhost")
           redis.del( "arduinos")
      end
   end

end
