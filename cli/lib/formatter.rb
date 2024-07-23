class Formatter
  attr_reader :indent, :width

  def initialize(writer, indent: '\t', width: 0)
    @writer = writer
    @indent = indent
    @width = width
    @current_width = 0
  end

  def write(b)
    formatted_text = format(b)
    @writer.write(formatted_text)
  end

  def format(b)
    formatted_text = ''
    lines = b.split("\n")

    lines.each do |line|
      line.strip! # Remove leading and trailing whitespace

      # Insert indentation if a new line.
      if @indent.length.positive? && @current_width.zero?
        formatted_text << @indent
        @current_width = @indent.length
      end

      # Check each word in the line
      line.split.each do |word|
        word_length = word.length

        if @current_width + word_length + 1 <= @width || @current_width.zero?
          formatted_text << ' ' if @current_width.positive?
          formatted_text << word
          @current_width += word_length + 1
        else
          formatted_text << "\n" << @indent << word
          @current_width = @indent.length + word_length
        end
      end

      formatted_text << "\n"
      @current_width = 0
    end

    formatted_text
  end
end
