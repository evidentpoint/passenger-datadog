module Parsers
  class Root < Base
    STATS = {
      'process_count' => 'pool.used',
      'max' => 'pool.max',
      'get_wait_list_size' => 'request_queue'
    }.freeze

    protected

    def default_stats
      STATS
    end
  end
end
