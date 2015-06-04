require 'yahoo_content_analysis'

YahooContentAnalysis.configure { |y|
  y.api_key = ENV['YAHOO_API_KEY']
  y.api_secret = ENV['YAHOO_API_SECRET']
}

uri = 'http://www.npr.org/2015/06/03/411524156/in-search-of-the-red-cross-500-million-in-haiti-relief'
r = YahooContentAnalysis::Client.new.analyze(uri)
puts r.inspect
