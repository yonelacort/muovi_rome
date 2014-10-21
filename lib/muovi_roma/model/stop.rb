module MuoviRoma
  module Model
    class Stop
      attr_accessor :name, :datetime

      def initialize(name, datetime)
        @name     = name
        @datetime = datetime
      end
    end
  end
end
