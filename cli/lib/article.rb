require_relative "./formatter"

class Article 
  attr_reader :title, :link, :body

  def initialize(title,link)
    @title = title
    @link = link 
    @body = ''
    @formatter = Formatter.new(STDOUT, indent: '', width: 100)
  end

  def fetch_body
    doc = Nokogiri::HTML(URI.open(@link))
    paragraphs = doc.css('div.articlebodycontent > p:not(.related-topics-list)')
     
    lines = paragraphs.map { |p| "#{p.content}\n"}
    @body = @formatter.format(lines.join("\n"))
  end

  def read 
    to_s
  end

  def summarize
  end

  def to_s
    header = "*" * 100
    "#{header}\n#{@title}\n#{header}\n\n#{@body}"
  end

end
