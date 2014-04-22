# lita-idobata

**lita-idobata** is an adapter for [Lita](https://github.com/jimmycuadra/lita) that allows you to use the robot with [Idobata](https://idobata.io).

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

gem 'lita', '~> 3.1.0'
gem "lita-idobata"
gem "pusher-client", github: 'pusher/pusher-ruby-client' # v0.5.1 is not released yet
...
```

```ruby
# lita_config.rb

Lita.configure do |config|
  config.robot.name = "your-bot-name"
  config.robot.log_level = :info
  config.robot.adapter = :idobata
  config.adapter.api_token = '123456abcd***'
end
```

## Contributing

1. Fork it ( http://github.com/fukayatsu/lita-idobata/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
