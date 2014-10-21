module MuoviRoma
  module Parser
    class Node
      def self.parse(node, date, timezone)
        new(node, date, timezone).parse
      end

      def initialize(node, date, timezone)
        @node     = node
        @date     = date
        @timezone = timezone
      end

      def parse
        Model::Node.new(
          datetime: datetime,
          name:     @node["nome"],
          lat:      @node["punto"]["y"].to_f,
          lng:      @node["punto"]["x"].to_f,
          type:     type
        )
      end

      def datetime
        DateTimeBuilder.build(@date, @node["t"], @timezone)
      end

      def type
        case @node["tipo"]
        when "F"
          :stop
        when "L"
          :place
        else
          :address
        end
      end
    end
  end
end
