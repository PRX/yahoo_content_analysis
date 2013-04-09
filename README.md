# YahooContentAnalysis

Use the Yahoo! Content Analysis API to extract topics and entities.

OAuth access is implemented, though not necessary (the docs imply higher limitd if requests are signed).  This should be a useful example for those wanting to do 2-legged OAuth access to Yahoo APIs using Faraday and the OAuth Faraday Middleware.

N.B. - I am not seeing the additional metadata nor related entities returned as the Yahoo docs claim they should.

## Installation

Add this line to your application's Gemfile:

    gem 'yahoo_content_analysis'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install yahoo_content_analysis

## Usage

    require 'yahoo_content_analysis'

    YahooContentAnalysis.configure{|y| 
      y.api_key = ENV['YAHOO_API_KEY']
      y.api_secret = ENV['YAHOO_API_SECRET']
    }

    r = YahooContentAnalysis::Client.new.analyze('Italian sculptors and painters of the renaissance favored the Virgin Mary for inspiration.')

    names = r.entities.collect{|e| e.name}

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
