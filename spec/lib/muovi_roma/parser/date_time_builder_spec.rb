describe MuoviRoma::Parser::DateTimeBuilder do
  let(:timezone) { TZInfo::Timezone.get("Europe/Rome") }
  let(:date)     { "2014-12-10" }

  describe "build" do
    let(:datetime) { described_class.build(date, time, timezone) }

    context "when is PM time" do
      let(:time) { "12:10 PM" }

      it "builds the expected time" do
        expect(datetime.iso8601).to eq("2014-12-10T12:10:00+01:00")
      end
    end

    context "when is AM time" do
      let(:time) { "10:10 AM" }

      it "builds the expected time" do
        expect(datetime.iso8601).to eq("2014-12-10T10:10:00+01:00")
      end
    end
  end
end
