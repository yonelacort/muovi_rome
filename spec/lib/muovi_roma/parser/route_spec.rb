describe MuoviRoma::Parser::Route do
  let(:session_id) { "bjcxbeg5f2xe4gdzyemhobhhj485iz8l" }
  let(:from)       { "Via Cavour, 6" }
  let(:to)         { "Via dei Prati dei Papa, 41" }
  let(:datetime)   { "2014-10-20 12:00:00" }
  let(:options) do
    { mezzo: 1, piedi: 1, bus: true, metro: true, ferro: true, carpooling: false, max_distanza_bici: 1000, when: 2}
  end
  let(:route) do
    VCR.use_cassette("routes") do
      client = MuoviRoma::Client.new.send(:client, "/ws/xml/percorso/2")
      response = client.call("percorso.Cerca", session_id, from, to, options, datetime, "en")
      response["indicazioni"]
    end
  end
  let(:parsed_route) { described_class.parse(route, datetime) }

  describe "parse route" do
    describe "segments" do
      it "the number of sections is equivalent to the movements" do
        expect(parsed_route.sections.count).to eq(5)
      end
    end
  end

  describe "date" do
    let(:date) { described_class.new(double, datetime).send(:date) }

    it "extracts the date" do
      expect(date).to eq("2014-10-20")
    end
  end
end
