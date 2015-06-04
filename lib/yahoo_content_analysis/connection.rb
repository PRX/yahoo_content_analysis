# encoding: utf-8

require 'faraday_middleware'

module YahooContentAnalysis
  module Connection

    ALLOWED_OPTIONS = [
      :headers,
      :url,
      :params,
      :request,
      :ssl
    ].freeze

    def add_default_options(opts={})
      headers = opts.delete(:headers) || {}
      options = {
        :consumer_key => api_key,
        :consumer_secret => api_secret,
        :headers => {
          # generic http headers
          'User-Agent'   => user_agent,
          'Accept'       => 'application/json;charset=utf-8'
        },
        :ssl => {:verify => false},
        :url => endpoint
      }.merge(opts)
      options[:headers] = options[:headers].merge(headers)
      options
    end

    def connection(options={})
      opts = add_default_options(options)
      oauth = oauth_opts(opts)
      Faraday::Connection.new(opts) do |connection|
        connection.request :oauth, oauth if oauth
        connection.request :url_encoded
        connection.response :mashify
        connection.response :logger if ENV['DEBUG']
        connection.response :json
        connection.adapter(adapter)
      end
    end

    def oauth_opts(opts)
      oauth_opts =  if opts.key?(:consumer_secret) && opts.key?(:consumer_key)
        {:consumer_secret => opts.delete(:consumer_secret), :consumer_key => opts.delete(:consumer_key)}
      else
        nil
      end
    end
  end
end
