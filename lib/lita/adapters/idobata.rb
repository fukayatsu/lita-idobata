require 'lita'
require 'lita/adapters/idobata/connector'

module Lita
  module Adapters
    class Idobata < Adapter
      require_configs :api_token

      def initialize(robot)
        super
        @connector = Connector.new(robot,
          api_token:   config.api_token,
          pusher_key:  pusher_key,
          idobata_url: idobata_url,
          debug:       debug,
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

      def config
        Lita.config.adapter
      end

      def debug
        config.debug || false
      end

      def pusher_key
        config.pusher_key || '44ffe67af1c7035be764'
      end

      def idobata_url
        config.idobata_url || 'https://idobata.io'
      end
    end

    Lita.register_adapter(:idobata, Idobata)
  end
end