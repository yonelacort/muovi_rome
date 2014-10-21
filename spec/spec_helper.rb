require 'bundler/setup'
Bundler.setup

require 'muovi_roma'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/cassettes'
  c.hook_into :webmock
  c.default_cassette_options = { record: :new_episodes }
end
