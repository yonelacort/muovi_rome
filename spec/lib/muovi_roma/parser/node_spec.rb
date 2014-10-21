describe MuoviRoma::Parser::Node do
  let(:node) do
    {
      "numero"=>0,
      "t"=>"12:00 PM",
      "tipo"=>"I",
      "nome"=>"Via Cavour 6",
      "url"=>"",
      "info_exp"=>"",
      "id"=>"",
      "icona"=>"nodo.png",
      "punto"=>{"y"=>"41.900547", "x"=>"12.499516"}
    }
  end
  let(:timezone)    { TZInfo::Timezone.get("Europe/Rome") }
  let(:date)        { "2014-12-20" }
  let(:parsed_node) { described_class.parse(node, date, timezone) }

  describe "parse returns a node that has" do
    it "datetime" do
      expect(parsed_node.datetime.iso8601).to eq("2014-12-20T12:00:00+01:00")
    end

    it "lat" do
      expect(parsed_node.lat).to eq(41.900547)
    end

    it "lng" do
      expect(parsed_node.lng).to eq(12.499516)
    end

    it "type" do
      expect(parsed_node.type).to eq(:address)
    end

    it "name" do
      expect(parsed_node.name).to eq("Via Cavour 6")
    end
  end
end
