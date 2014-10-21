require "json"

describe MuoviRoma::Client do
  describe "authentication" do
    let(:response) do
      VCR.use_cassette("authentication") do
        described_class.new.authentication
      end
    end

    it "returns a session" do
      expect(response).to_not be_empty
    end
  end

  describe "routes" do
    let(:session_id) { "bjcxbeg5f2xe4gdzyemhobhhj485iz8l" }
    let(:from)       { "Via Cavour, 6" }
    let(:to)         { "Via dei Prati dei Papa, 41" }
    let(:datetime)   { "2014-10-20 12:00:00" }
    let(:options) do
      { mezzo: 1, piedi: 1, bus: true, metro: true, ferro: true, carpooling: false, max_distanza_bici: 1000, when: 2}
    end
    let(:route) do
      VCR.use_cassette("routes") do
        described_class.new.routes(session_id, from, to, datetime, options)
      end
    end

    it "returns a route with sections" do
      expect(route.sections).to_not be_empty
    end
  end
end
