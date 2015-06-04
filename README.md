# YahooContentAnalysis

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](http://opensource.org/licenses/MIT)
[![Build Status](https://travis-ci.org/PRX/yahoo_content_analysis.svg?branch=master)](https://travis-ci.org/PRX/yahoo_content_analysis)
[![Code Climate](https://codeclimate.com/github/PRX/yahoo_content_analysis/badges/gpa.svg)](https://codeclimate.com/github/PRX/yahoo_content_analysis)
[![Coverage Status](https://coveralls.io/repos/PRX/yahoo_content_analysis/badge.svg?branch=master)](https://coveralls.io/r/PRX/yahoo_content_analysis?branch=master)
[![Dependency Status](https://gemnasium.com/PRX/yahoo_content_analysis.svg)](https://gemnasium.com/PRX/yahoo_content_analysis)

Use the Yahoo! Content Analysis API to extract topics and entities.

OAuth access is implemented, though not necessary (the docs imply higher limits if requests are signed).  This should be a useful example for those wanting to do 2-legged OAuth access to Yahoo APIs using Faraday and the OAuth Faraday Middleware.

N.B. - I am not seeing the additional metadata nor related entities returned as the Yahoo docs claim they should.

## Installation

Add this line to your application's Gemfile:

    gem 'yahoo_content_analysis'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install yahoo_content_analysis

## Usage
```ruby
require 'yahoo_content_analysis'

YahooContentAnalysis.configure{|y|
  y.api_key = ENV['YAHOO_API_KEY']
  y.api_secret = ENV['YAHOO_API_SECRET']
}

r = YahooContentAnalysis::Client.new.analyze('Italian sculptors and painters of the renaissance favored the Virgin Mary for inspiration.')

names = r.entities.collect{|e| e.name}

# you can also query a uri
uri = 'http://www.npr.org/2015/06/03/411524156/in-search-of-the-red-cross-500-million-in-haiti-relief'
r = YahooContentAnalysis::Client.new.analyze(uri)

names = r.entities.collect{|e| e.name}
```
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
