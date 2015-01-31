require 'lita'
require 'lita/adapters/idobata/connector'

module Lita
  module Adapters
    class Idobata < Adapter
      config :api_token
      config :pusher_key,  default: '44ffe67af1c7035be764'
      config :idobata_url, default: 'https://idobata.io'
      config :debug,       default: false

      def initialize(robot)
        super
        @connector = Connector.new(robot,
          api_token:   adapter_config.api_token,
          pusher_key:  adapter_config.pusher_key,
          idobata_url: adapter_config.idobata_url,
          debug:       adapter_config.debug,
        )
      end
      attr_reader :connector

      # Idobata does not support these methods.
      def join; end
      def part; end
      def set_topic; end

      def send_messages(target, strings)
        connector.message(target, strings)
      end

      def run
        connector.connect
        robot.trigger(:connected)
        sleep
      rescue Interrupt
        shut_down
      end

      def shut_down
        connector.shut_down
        robot.trigger(:disconnected)
      end

      def mention_format(name)
        "@#{name}"
      end

    private

      def adapter_config
        robot.config.adapters.idobata
      end
    end
    Lita.register_adapter(:idobata, Idobata)
  end
end
