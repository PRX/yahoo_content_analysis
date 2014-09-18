# encoding: utf-8

module YahooContentAnalysis
  class Client

    include Connection

    attr_reader *YahooContentAnalysis::Configuration.keys

    attr_accessor :current_options

    class_eval do
      YahooContentAnalysis::Configuration.keys.each do |key|
        define_method "#{key}=" do |arg|
          self.instance_variable_set("@#{key}", arg)
          self.current_options.merge!({:"#{key}" => arg})
        end
      end
    end

    def initialize(options={}, &block)
      setup(options)
      yield(self) if block_given?
    end

    def setup(options={})
      opts = Hash[options.map{ |k, v| [k.to_sym, v] }]
      opts = YahooContentAnalysis.options.merge(opts)
      self.current_options = opts
      Configuration.keys.each do |key|
        send("#{key}=", opts[key])
      end
    end

    def analyze(content, opts={})
      content = content.to_s.squish
      response = connection.post do |request|
        request.body = options(content)
      end
      YahooContentAnalysis::Response.new(response)
    end

    def query(content)
      "SELECT * FROM contentanalysis.analyze WHERE related_entities = \"true\" and #{condition(content)}"
    end

    def condition(content)
      uri?(content) ? url(content) : text(content)
    end

    def url(content)
      %{ url = "#{content}" }
    end

    def text(content)
      %{ text = "#{content.gsub('"', '\"')}" }
    end

    def options(content)
      {
        'q'                => query(content),
        'format'           => 'json',
        'max'              => '50',
        'related_entities' => 'true',
        'show_metadata'    => 'true'
      }
    end

    def uri?(string)
      uri = URI.parse(string)
      %w( http https ).include?(uri.scheme)
    rescue URI::BadURIError
      false
    rescue URI::InvalidURIError
      false
    end

  end
end
