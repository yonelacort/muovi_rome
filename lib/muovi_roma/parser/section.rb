module MuoviRoma
  module Parser
    class Section
      def self.parse(start_node, end_node, section, date, timezone)
        new(start_node, end_node, section, date, timezone).parse
      end

      def initialize(start_node, end_node, section, date, timezone)
        @start_node = start_node
        @end_node   = end_node
        @section    = section
        @date       = date
        @timezone   = timezone
      end

      def parse
        Model::Section.new(
          from:         parse_node(@start_node),
          to:           parse_node(@end_node),
          line:         @section["linea"],
          destination:  @section["dest"],
          transport:    transport,
          stops:        stops,
          duration:     duration,
          waiting_time: waiting_time
        )
      end

      private

      def parse_node(node)
        Node.parse(node, @date, @timezone)
      end

      def duration
        duration = @section["info_tratto"].gsub(/(.+)? \((.+)? minutes\)/, "\\2")
        duration ? duration.to_i * 60 : 0
      end

      def stops
        return [] if transport == :walk
        stops = @section["info_tratto_exp"].gsub("<br />", "").split("&nbsp\;")
        stops.map { |stop| parse_stop(stop) }.compact
      end

      def parse_stop(stop)
        return if stop.empty?
        time = stop.gsub(/^(\d\d:\d\d)? (AM|PM) (.+)?/, "\\1 \\2")
        datetime = DateTimeBuilder.build(@date, time, @timezone)
        Model::Stop.new($3, datetime)
      end

      def waiting_time
        waiting = @section["tempo_attesa"].gsub(/minutes/, "").strip
        waiting ? waiting.to_i * 60 : 0
      end

      def transport
        case @section["mezzo"]
        when "P", "I"
          :walk
        when "B"
          :bus
        when "M"
          :subway
        when "T"
          :train
        when "CP"
          :car_pooling
        when "A"
          :private_car
        when "CS"
          :car_sharing
        else
          nil
        end
      end
    end
  end
end
