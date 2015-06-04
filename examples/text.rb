require 'yahoo_content_analysis'

YahooContentAnalysis.configure { |y|
  y.api_key = ENV['YAHOO_API_KEY']
  y.api_secret = ENV['YAHOO_API_SECRET']
}

text = 'Italian sculptors and painters of the renaissance favored the Virgin Mary for inspiration.'
r = YahooContentAnalysis::Client.new.analyze(text)
puts r.inspect
