# MuoviRoma

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'muovi_roma'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install muovi_roma

## Usage

### Create a session

In order to use the interface, it's required to create a session token and use in every request to be authorized as a consumer of the API to do requests.

```ruby
# The user_id is an optional attribute but recommendable to associate a session to a user
user_id = 2
client = MuoviRoma::Client.new(key: "you-api-key")
client.authentication(user_id)
```

### Routes search

```ruby
# The user_id is an optional attribute but recommendable to associate a session to a user
user_id = 2
client = MuoviRoma::Client.new(key: "you-api-key")
session_token = "bjcxbeg5f2xe4gdzyemhobhhj485iz8l"
from = "Via Cavour, 6"
to = "Via dei Prati dei Papa, 41"
datetime = "2014-10-20 12:00:00"
options = {
  mezzo: 1,
  piedi: 1,
  bus: true,
  metro: true,
  ferro: true,
  carpooling: false,
  max_distanza_bici: 1000,
  when: 2
}
client.routes(session_id, from, to, datetime, options)
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/muovi_roma/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
