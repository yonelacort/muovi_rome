module MuoviRoma
  require "tzinfo"
  require "muovi_roma/version"
  require "muovi_roma/model"
  require "muovi_roma/parser"
  require "muovi_roma/uri"
  require "muovi_roma/client"
  require "muovi_roma/xmlrpc_client"

  XMLRPC::Config::ENABLE_NIL_PARSER = true
end
