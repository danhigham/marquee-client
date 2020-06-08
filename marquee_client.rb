require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/json'
require 'bunny'

class MarqueeClient < Sinatra::Base

    configure do
        set :server, "thin"
        set :port, 8080
        set :static, true
        set :public_folder, "assets"
    end

    configure :development do
        register Sinatra::Reloader
    end

    get '/' do
        haml :index, :layout => :default
    end

    post '/post_message', :provides => :json do
        message = request.body.read

        connection = Bunny.new(
            hostname: ENV['RABBIT_HOST'], 
            username: ENV['RABBIT_USER'],
            password: ENV['RABBIT_PASSWORD']
        )
        connection.start

        channel = connection.create_channel
        queue = channel.queue(ENV['QUEUE'])

        channel.default_exchange.publish(message, routing_key: queue.name)

        json :error => ''
    end

end
