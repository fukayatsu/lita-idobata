# lita-idobata

**lita-idobata** is an adapter for [Lita](https://github.com/jimmycuadra/lita) that allows you to use the robot with [Idobata](https://idobata.io).

**v0.1.x** for lita >= 4.0
**v0.0.x** for ltia >= 2.5

## Installation

Add this line to your application's Gemfile:

    gem 'lita-idobata'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lita-idobata

## Usage

```
# Gemfile of your lita

source "https://rubygems.org"

gem 'lita', '~> 4.2.0'
gem "lita-idobata"
gem "pusher-client"
...
```

```ruby
# lita_config.rb

Lita.configure do |config|
  config.robot.name = "your-bot-name"
  config.robot.adapter = :idobata
  config.adapters.idobata.api_token = '123456abcd***'
  ...
end
```

example (for heroku): https://github.com/fukayatsu/kamabata-fkbot

## Contributing

1. Fork it ( http://github.com/fukayatsu/lita-idobata/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
