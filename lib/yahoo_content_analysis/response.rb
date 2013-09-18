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

      parse(response) if response
    end

    def humanize_topic(topic)
      topic.titleize.remove_formatting
    end

    def parse(response=raw)
      return if (response.nil?)
      return if (!response.respond_to?(:body))
      return if (!response.body['query'] || !response.body['query']['results'])

      r = response.body['query']['results']
      @language = get_language(r['lang'])

      yahoo_categories = (r['yctCategories'] || {})['yctCategory'] || []
      yahoo_categories = [yahoo_categories] unless yahoo_categories.is_a?(Array)
      @topics = yahoo_categories.collect do |cat|
        {:name => humanize_topic(cat['content']), :score => cat['score'].to_f, :original=>cat['content']}
      end

      yahoo_entities = (r['entities'] || {})['entity'] || []
      yahoo_entities = [yahoo_entities] unless yahoo_entities.is_a?(Array)
      entities_hash = yahoo_entities.inject({}) do |hash, ent|
        # puts "entity: #{ent.inspect}"
        name = ent['text']['content']
        if hash.has_key?(name)
          existing = hash[name]
          existing[:score] = [existing[:score], ent['score'].to_f].max
        else
          type = extract_type(ent['types'])

          entity = {:name => ent['text']['content'], :score => ent['score'].to_f}
          entity[:type] = type if type
          entity[:wikipedia_url] = ent['wiki_url'] if ent['wiki_url']

          ## these aren't showing up in any results, so not worrying about them
          # if cat['related_entities'] && cat['related_entities']['wikipedia']
          # end

          hash[name] = entity
        end

        hash
      end

      @entities = entities_hash.values

    end

    def get_language(lang)
      return nil unless lang
      l = LanguageList::LanguageInfo.find(lang.split('-')[0].downcase)
      l.name
    end

    def extract_type(h)
      # puts "extract_type: #{h.inspect}"
      return nil unless (h && h['type'])
      type = h['type'].is_a?(Array) ? h['type'].first : h['type']
      content = (type['content'] || '').split('/')
      content = (content[1] || content[0]).remove_formatting.titleize
      content.blank? ? nil : content
    end

  end
end