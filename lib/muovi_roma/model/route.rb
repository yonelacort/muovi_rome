module MuoviRoma
  module Model
    class Route
      attr_accessor :sections

      def initialize(sections)
        @sections = sections
      end
    end
  end
end
