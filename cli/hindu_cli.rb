# frozen_string_literal: true

require 'tty-prompt'
require 'tty-pager'
require_relative './lib/category_manager'
require_relative './lib/loader'

class HinduCLI
  def initialize
    @prompt = TTY::Prompt.new
    @pager = TTY::Pager.new
    @categories = CategoryManager.new
  end

  def run
    puts 'Welcome to the Hindu CLI'
    display_categories
  end

  def display_categories
    loop do
      puts 'Please select a category by number'
      category = @prompt.select('Select category:', @categories.get_category + ['Quit'], cycle: true, per_page: 10,
                                                                                         filter: true)
      break if category == 'Quit'

      Loader.load(:classic) { category.fetch_articles }
      display_articles(category)
    end
  end

  def display_articles(category)
    loop do
      selected_option = select_article(category)
      case selected_option
      when 'Go back'
        break
      when 'Quit'
        exit(0)
      else
        display_article(selected_option)
        break unless continue_reading?
      end
    end
  end

  def select_article(category)
    @prompt.select('Select an article:', category.get_article_link_map + ['Go back', 'Quit'], cycle: true,
                                                                                              filter: true, per_page: 10)
  end

  def display_article(article)
    Loader.load(:classic) { article.fetch_body }
    @pager.page article
  end

  def continue_reading?
    choice = @prompt.select('What would you like to do?', ['Continue reading', 'Quit'])
    choice == 'Continue reading'
  end
end
