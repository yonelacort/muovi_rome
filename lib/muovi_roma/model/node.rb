module MuoviRoma
  module Model
    class Node
      attr_accessor :lat, :lng, :datetime, :name, :type

      def initialize(options)
        @lat      = options[:lat]
        @lng      = options[:lng]
        @datetime = options[:datetime]
        @name     = options[:name]
        @type     = options[:type]
      end
    end
  end
end
