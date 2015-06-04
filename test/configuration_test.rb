require 'test_helper'

module TestConfig
  extend YahooContentAnalysis::Configuration
end

describe YahooContentAnalysis::Configuration do

  let(:config) { YahooContentAnalysis::Configuration }

  it 'can be configured' do
    TestConfig.configure do |c|
      c.must_be_kind_of config
    end
  end

  it 'has default keys' do
    config.keys.must_equal config::VALID_OPTIONS_KEYS
  end
end
