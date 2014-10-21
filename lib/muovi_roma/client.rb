require "xmlrpc/client"

module MuoviRoma
  class Client
    def initialize(options = {})
      @key = ENV["API_KEY"] || options[:key]
    end

    def authentication(user_id = "")
      client("/ws/xml/autenticazione/1").call("autenticazione.Accedi", @key, user_id)
    end

    def routes(session_id, from, to, datetime, options, locale = "en")
      client   = client("/ws/xml/percorso/2")
      response = client.call("percorso.Cerca", session_id, from, to, options, datetime, locale)
      Parser::Route.parse(response["indicazioni"], datetime)
    end

    private

    def client(path)
      client = XMLRPC::Client.new("muovi.roma.it", path)
      client.http_header_extra = { 'Content-Type' => 'application/xml' }
      client
    end
  end
end
