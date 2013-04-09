# encoding: utf-8
require 'language_list'

module YahooContentAnalysis
  class Response
    attr_accessor :raw, :language, :topics, :tags, :entities, :relations, :locations

    def initialize(response)
      @raw  = response

      @language = nil
      @topics    = []
      @tags      = []
      @entities  = []
      @relations = []
      @locations = []

      parse(response)
    end

    def parse(response)
      r = response.body['query']['results'] || {} 
      @language = get_language(r['lang'])

      @topics = Array((r['yctCategories'] || {})['yctCategory']).collect do |cat|
        {:name => cat['content'], :score => cat['score']}
      end

      @entities = Array((r['entities'] || {})['entity']).collect do |ent|
        type = extract_type(ent['types'])

        entity = {:name => ent['text']['content'], :score => ent['score']}
        entity[:type] = type if type
        entity[:wikipedia_url] = ent['wiki_url'] if ent['wiki_url']

        ## these aren't showing up in any results, so not worrying about them
        # if cat['related_entities'] && cat['related_entities']['wikipedia']
        # end

        entity
      end

    end

    def get_language(lang)
      return nil unless lang
      l = LanguageList::LanguageInfo.find(lang.split('-')[0].downcase)
      l.name
    end

    def extract_type(h)
      return nil unless (h && h['type'])
      type = h['type'].is_a?(Array) ? h['type'].first : h['type']
      (type['content'] || '').sub(/^\/(.*)/, '')
    end

  end
end