require 'nokogiri'
require 'open-uri'
require 'securerandom'
require_relative './article'

class Category
  attr_reader :name, :rss_url, :articles
  def initialize(name, rss_url)
    @name = name
    @rss_url = rss_url
    @articles = []
  end
  
  def add_article(article)
    @articles << article
  end

  def fetch_articles
    feed = Nokogiri::XML(URI.open(rss_url))
      feed.xpath("//item").each do | item |
        title = item.xpath('title').text
        link = item.xpath('link').text
        @articles << Article.new(title, link)
    end

  rescue StandardError => e
    puts "Error fetching or parsing the RSS feed: #{e.message}"
    exit 1
  end

  def get_article_link_map
    @articles.map { | a | { name: a.title, value: a }} 
  end
end
