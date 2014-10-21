module MuoviRoma
  module Parser
    class Route
      def self.parse(route, datetime)
        new(route, datetime).parse
      end

      def initialize(route, datetime)
        @route = route
        @datetime = datetime
      end

      def parse
        Model::Route.new(sections)
      end

      private

      def sections
        sections = []
        @route.each_cons(3) do |start_node, section, end_node|
          next unless end_node["nodo"]
          sections << Section.parse(start_node["nodo"], end_node["nodo"], section["tratto"], date, timezone)
        end
        sections
      end

      def date
        @datetime.gsub(/^(.*)? (.*)?/, "\\1")
      end

      def timezone
        @timezone ||= TZInfo::Timezone.get("Europe/Rome")
      end
    end
  end
end
