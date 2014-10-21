module MuoviRoma
  module Model
    class Section
      attr_accessor :from, :to, :line, :destination, :transport, :stops, :distance, :duration, :waiting_time

      def initialize(options)
        @from         = options[:from]
        @to           = options[:to]
        @line         = options[:line]
        @destination  = options[:destination]
        @transport    = options[:transport]
        @stops        = options[:stops]
        @distance     = options[:distance]
        @duration     = options[:duration]
        @waiting_time = options[:waiting_time]
      end
    end
  end
end
