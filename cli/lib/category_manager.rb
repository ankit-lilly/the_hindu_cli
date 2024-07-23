# frozen_string_literal: true

require_relative './constants'
require_relative './category'

class CategoryManager
  include Constants

  def initialize
    @categories = {}
    initialize_categories
  end

  def initialize_categories
    CATEGORIES.each do |category, rss_url|
      @categories[category] = Category.new(category, "#{BASE_URL}#{rss_url}")
    end
  end

  def select_category; end

  def names
    @categories.keys
  end

  def get_category
    names.map do |ky|
      { name: ky, value: @categories[ky] }
    end
  end
end
