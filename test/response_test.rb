require 'test_helper'

describe YahooContentAnalysis::Response do

  it 'is initialized with json' do
    oc = YahooContentAnalysis::Response.new("{}")
    oc.wont_be_nil
  end

  it 'gets tags for text' do

    body = {"query"=>{"count"=>1, "created"=>"2015-06-04T01:01:34Z", "lang"=>"en-US", "results"=>{"entities"=>{"entity"=>[{"score"=>"0.882", "text"=>{"end"=>"12", "endchar"=>"12", "start"=>"0", "startchar"=>"0", "content"=>"Ruby on Rails"}, "wiki_url"=>"http://en.wikipedia.com/wiki/Ruby_on_Rails"}, {"score"=>"0.701", "text"=>{"end"=>"41", "endchar"=>"41", "start"=>"29", "startchar"=>"29", "content"=>"web framework"}, "wiki_url"=>"http://en.wikipedia.com/wiki/Web_application_framework"}, {"score"=>"0.64", "text"=>{"end"=>"89", "endchar"=>"89", "start"=>"65", "startchar"=>"65", "content"=>"ruby programming language"}, "wiki_url"=>"http://en.wikipedia.com/wiki/Ruby_%28programming_language%29"}]}}}}

    mock_message = Minitest::Mock.new
    4.times { mock_message.expect(:body, body) }
    mock_message.expect(:nil?, false)

    response = YahooContentAnalysis::Response.new(mock_message)
    response.entities.count.must_equal 3
  end

  it 'gets tags for a url' do

    body =  {"query"=>{"count"=>2, "created"=>"2015-06-04T01:18:24Z", "lang"=>"en-US", "results"=>{"yctCategories"=>{"yctCategory"=>[{"score"=>"0.952", "content"=>"Society & Culture"}, {"score"=>"0.693333", "content"=>"Volunteering & Philanthropy"}, {"score"=>"0.666667", "content"=>"Society & Culture Organizations"}]}, "entities"=>{"entity"=>[{"score"=>"0.959", "text"=>{"end"=>"19248", "endchar"=>"19248", "start"=>"19236", "startchar"=>"19236", "content"=>"The Red Cross"}, "wiki_url"=>"http://en.wikipedia.com/wiki/American_Red_Cross"}, {"score"=>"0.943", "text"=>{"end"=>"36452", "endchar"=>"36443", "start"=>"36440", "startchar"=>"36431", "content"=>"The Red Cross"}}, {"score"=>"0.93", "text"=>{"end"=>"19271", "endchar"=>"19271", "start"=>"19267", "startchar"=>"19267", "content"=>"Haiti"}, "wiki_url"=>"http://en.wikipedia.com/wiki/Haiti", "types"=>{"type"=>{"region"=>"us", "content"=>"/place/destination"}}}, {"score"=>"0.919", "text"=>{"end"=>"35722", "endchar"=>"35713", "start"=>"35714", "startchar"=>"35705", "content"=>"Red Cross"}, "types"=>{"type"=>{"region"=>"us", "content"=>"/organization"}}}, {"score"=>"0.916", "text"=>{"end"=>"35673", "endchar"=>"35664", "start"=>"35669", "startchar"=>"35660", "content"=>"Haiti"}, "types"=>{"type"=>[{"region"=>"us", "content"=>"/place"}, {"region"=>"us", "content"=>"/place/destination"}]}}, {"score"=>"0.87", "text"=>{"end"=>"31454", "endchar"=>"31445", "start"=>"31444", "startchar"=>"31435", "content"=>"Marie Arago"}, "types"=>{"type"=>{"region"=>"us", "content"=>"/person"}}}, {"score"=>"0.583", "text"=>{"end"=>"36220", "endchar"=>"36211", "start"=>"36208", "startchar"=>"36199", "content"=>"David Meltzer"}, "types"=>{"type"=>{"region"=>"us", "content"=>"/person"}}}]}}}}

    mock_message = Minitest::Mock.new
    4.times { mock_message.expect(:body, body) }
    mock_message.expect(:nil?, false)

    response = YahooContentAnalysis::Response.new(mock_message)
    response.entities.count.must_equal 5
  end
end
