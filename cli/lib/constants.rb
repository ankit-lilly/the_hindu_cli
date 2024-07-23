# frozen_string_literal: true

module Constants
  BASE_URL = 'https://www.thehindu.com'
  CATEGORIES = {
    'home' => '/feeder/default.rss',
    'business' => '/business/feeder/default.rss',
    'sports' => '/sport/feeder/default.rss',
    'entertainment' => '/entertainment/feeder/default.rss',
    'opinion' => '/opinion/feeder/default.rss'
  }.freeze
end
