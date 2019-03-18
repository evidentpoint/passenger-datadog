module Parsers
  class Base
    PREFIX = 'passenger'.freeze

    attr_reader :batch, :xml, :prefix, :tags

    def initialize(batch, xml, prefix: nil, tags: nil)
      @batch = batch
      @xml = xml
      @prefix = prefix
      @tags = tags
    end

    def run(opts = nil)
      valid_opts = opts.nil? || !(opts.is_a?(Array) || opts.is_a?(Hash))
      stats = valid_opts ? opts : default_stats

      if stats.is_a?(Array)
        stats.each do |k|
          gauge(k, k)
        end
      elsif stats.is_a?(Hash)
        stats.each do |k, v|
          gauge(k, v)
        end
      end
    end

    protected

    def default_stats
      {}
    end

    def gauge(xml_key, key)
      value = xml.xpath(xml_key).text
      return if value.empty?

      if tags
        batch.gauge(key_for(key), value, tags: tags)
      else
        batch.gauge(key_for(key), value)
      end
    end

    def key_for(key)
      [PREFIX, prefix, key].compact.join('.')
    end
  end
end
