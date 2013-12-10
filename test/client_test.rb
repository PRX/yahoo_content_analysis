require 'yahoo_content_analysis'
YahooContentAnalysis.configure{|y| 
  y.api_key = ENV['YAHOO_API_KEY']
  y.api_secret = ENV['YAHOO_API_SECRET']
}

r = YahooContentAnalysis::Client.new.analyze('Italian sculptors and painters of the renaissance favored the Virgin Mary for inspiration.')
puts r.inspect
