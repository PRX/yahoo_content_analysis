# encoding: utf-8

# these are additional params from the docs, figure out how to use them - some don't seem to do squat.
# related_entities    boolean: true (default), false  Whether or not to include related entities/concepts in the response
# show_metadata       boolean: true (default), false  Whether or not to include entity/concept metadata in the response
# enable_categorizer  boolean: true (default), false  Whether or not to include document category information in the response
# unique              boolean: true, false (default)  Whether or not to detect only one occurrence of an entity or a concept that my appear multiple times
# max                 integer: 100 (default)          Maximum number of entities/concepts to detect

module YahooContentAnalysis

  module Configuration

    VALID_OPTIONS_KEYS = [
      :api_key,
      :api_secret,
      :adapter,
      :endpoint,
      :user_agent,
      :format,
      :max,
      :related_entities,
      :show_metadata,
      :enable_categorizer,
      :unique
    ].freeze

    VALID_PARAMS = [
      :format,
      :max,
      :related_entities,
      :show_metadata,
      :enable_categorizer,
      :unique
    ]

    # this you need to get from yahoo - go register an app!
    DEFAULT_API_KEY = nil

    DEFAULT_API_SECRET = nil

    # Adapters are whatever Faraday supports - I like excon alot, so I'm defaulting it
    DEFAULT_ADAPTER = :excon

    # The api endpoint for YQL
    DEFAULT_ENDPOINT = 'http://query.yahooapis.com/v1/public/yql'.freeze

    # The value sent in the http header for 'User-Agent' if none is set
    DEFAULT_USER_AGENT = "YahooContentAnalysis Ruby Gem #{YahooContentAnalysis::VERSION}".freeze

    DEFAULT_FORMAT = :json

    DEFAULT_MAX = 50

    DEFAULT_RELATED_ENTITIES = 'true'

    DEFAULT_SHOW_METADATA = 'true'

    DEFAULT_ENABLE_CATEGORIZER = 'true'

    DEFAULT_UNIQUE = 'true'

    attr_accessor *VALID_OPTIONS_KEYS

    # Convenience method to allow for global setting of configuration options
    def configure
      yield self
    end

    def self.extended(base)
      base.reset!
    end

    class << self
      def keys
        VALID_OPTIONS_KEYS
      end
    end

    def options
      options = {}
      VALID_OPTIONS_KEYS.each { |k| options[k] = send(k) }
      options
    end

    # Reset configuration options to their defaults
    def reset!
      self.api_key            = DEFAULT_API_KEY
      self.api_secret         = DEFAULT_API_SECRET
      self.adapter            = DEFAULT_ADAPTER
      self.endpoint           = DEFAULT_ENDPOINT
      self.user_agent         = DEFAULT_USER_AGENT
      self.format             = DEFAULT_FORMAT
      self.max                = DEFAULT_MAX
      self.related_entities   = DEFAULT_RELATED_ENTITIES
      self.show_metadata      = DEFAULT_SHOW_METADATA
      self.enable_categorizer = DEFAULT_ENABLE_CATEGORIZER
      self.unique             = DEFAULT_UNIQUE
      self
    end

  end
end