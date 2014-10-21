module MuoviRoma
  module Parser
    module DateTimeBuilder
      module_function

      def build(date, time, timezone)
        offset = offset(date, timezone)
        DateTime.parse("#{date} #{time} +0#{offset}:00")
      end

      private

      def self.offset(date, timezone)
        timezone.period_for_local(DateTime.parse(date)).utc_total_offset / 3600
      end
    end
  end
end

