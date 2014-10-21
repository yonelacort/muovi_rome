describe MuoviRoma::Parser::Section do
  let(:start_node) do
    {"numero"=>1, "t"=>"12:01 PM", "tipo"=>"F", "nome"=>"Termini", "url"=>"", "info_exp"=>"", "id"=>"BD11", "icona"=>"nodo.png", "punto"=>{"y"=>"41.901003", "x"=>"12.500143"}}
  end
  let(:end_node) do
    {"numero"=>2, "t"=>"12:14 PM", "tipo"=>"F", "nome"=>"Basilica San Paolo", "url"=>"", "info_exp"=>"", "id"=>"BD17", "icona"=>"nodo.png", "punto"=>{"y"=>"41.856011", "x"=>"12.478320"}}
  end
  let(:section) do
    {"mezzo"=>"M", "dist"=>5667.0, "id_linea"=>"MEBCom1", "dest"=>"Laurentina", "tipo_attesa"=>"S", "bounding_box"=>[[12.47656990112981, 41.90048754922531], [12.501876737445011, 41.856526107767834]], "numero"=>1, "url"=>"", "tempo_attesa"=>"3 minutes", "info_tratto"=>"For 6 stops (10 minutes)", "info_tratto_short"=>"6 stops", "info_tratto_exp"=>"&nbsp;12:05 PM Termini<br />&nbsp;12:06 PM Cavour<br />&nbsp;12:08 PM Colosseo<br />&nbsp;12:09 PM Circo Massimo<br />&nbsp;12:11 PM Piramide<br />&nbsp;12:12 PM Garbatella<br />&nbsp;12:14 PM Basilica San Paolo", "linea_short"=>"B", "id"=>"T-BD11-MEBCom12", "linea"=>"Metro B - B1", "icona"=>"metro.png"}
  end
  let(:timezone)       { TZInfo::Timezone.get("Europe/Rome") }
  let(:date)           { "2014-12-20" }
  let(:parsed_section) { described_class.parse(start_node, end_node, section, date, timezone) }

  describe "parse" do
    describe "from" do
      let(:node) { parsed_section.from }

      it "name" do
        expect(node.name).to eq("Termini")
      end

      it "datetime" do
        expect(node.datetime.iso8601).to eq("2014-12-20T12:01:00+01:00")
      end

      it "lat" do
        expect(node.lat).to eq(41.901003)
      end

      it "lng" do
        expect(node.lng).to eq(12.500143)
      end

      it "type" do
        expect(node.type).to eq(:stop)
      end
    end

    describe "to" do
      let(:node) { parsed_section.to }

      it "name" do
        expect(node.name).to eq("Basilica San Paolo")
      end

      it "datetime" do
        expect(node.datetime.iso8601).to eq("2014-12-20T12:14:00+01:00")
      end

      it "lat" do
        expect(node.lat).to eq(41.856011)
      end

      it "lng" do
        expect(node.lng).to eq(12.478320)
      end

      it "type" do
        expect(node.type).to eq(:stop)
      end
    end

    it "line" do
      expect(parsed_section.line).to eq("Metro B - B1")
    end

    it "destination" do
      expect(parsed_section.destination).to eq("Laurentina")
    end

    it "transport" do
      expect(parsed_section.transport).to eq(:subway)
    end

    describe "stops" do
      let(:stops) { parsed_section.stops }

      it "has the right number of stops" do
        expect(stops.count).to eq(7)
      end

      describe "first stop" do
        let(:stop) { stops.first }

        it "datetime" do
          expect(stop.datetime.iso8601).to eq("2014-12-20T12:05:00+01:00")
        end

        it "name" do
          expect(stop.name).to eq("Termini")
        end
      end

      describe "last stop" do
        let(:stop) { stops.last }

        it "datetime" do
          expect(stop.datetime.iso8601).to eq("2014-12-20T12:14:00+01:00")
        end

        it "name" do
          expect(stop.name).to eq("Basilica San Paolo")
        end
      end
    end

    it "duration" do
      expect(parsed_section.duration).to eq(600)
    end

    it "waiting_time" do
      expect(parsed_section.waiting_time).to eq(180)
    end

    it "distance" do
    end
  end
end
