# require 'lita/acapters/idobata/callback'

require "lita/idobata/version"
require 'pusher-client'
require 'faraday'
require 'json'

module Lita
  module Adapters
    class Idobata < Adapter
      class Connector
        attr_reader :robot, :client, :roster

        def initialize(robot, api_token: nil, pusher_key: nil, idobata_url: nil, debug: false)
          @robot       = robot
          @api_token   = api_token
          @pusher_key  = pusher_key
          @idobata_url = idobata_url
          @debug       = debug
          Lita.logger.info("Enabling log.") if @debug
        end

        def connect
          raise "api_token is requeired." unless @api_token

          response = http_client.get '/api/seed'
          seed = JSON.parse(response.body)
          @bot = seed['records']['bot']
          channel_name = @bot['channel_name']

          options = {
            encrypted: !!@idobata_url.match(/^https/),
            auth_method: auth_method
          }
          socket = PusherClient::Socket.new(@pusher_key, options)
          socket.connect(true)
          socket.bind('pusher:connection_established') do |data|
            socket_id = JSON.parse(data)['socket_id']
            socket.subscribe(channel_name, socket_id)
          end

          socket.bind('message:created') do |data|
            message = JSON.parse(data)["message"]
            if message["sender_id"] != @bot['id']
              user    = User.new(message["sender_id"], name: message["sender_name"])
              source  = Source.new(user: user, room: message["room_id"])
              message = Message.new(robot, message["body_plain"], source)
              robot.receive(message)
            end
          end
        end

        def message(target, strings)
          http_client.post '/api/messages', {
            'message[room_id]' => target.room,
            'message[source]' => strings.join("\n")
          }
        end

        def rooms
        end

        def shut_down
        end

      private

        def auth_method
          -> (socket_id, channel) {
            response = http_client.post "/pusher/auth", { channel_name: channel.name, socket_id: socket_id }
            json = JSON.parse(response.body)
            json["auth"]
          }
        end

        def http_client
          @conn ||= Faraday.new(url: @idobata_url) do |faraday|
            faraday.request  :url_encoded             # form-encode POST params
            faraday.response :logger                  # log requests to STDOUT
            faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
            faraday.headers['X-API-Token']  = @api_token
            faraday.headers['User-Agent']   = "lita-idobata / v#{Lita::Idobata::VERSION}"
          end
        end
      end
    end
  end
end
