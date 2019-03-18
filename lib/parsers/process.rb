module Parsers
  class Process < Base
    STATS = %w[
      processed
      sessions
      busyness
      concurrency
      cpu
      rss
      private_dirty
      pss
      swap
      real_memory
      vmsize
    ].freeze

    protected

    def default_stats
      STATS
    end
  end
end
