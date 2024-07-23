require 'thread'

module Loader
  SPINNERS = {
    classic: %w[| / - \\],
    dots: %w[⠋ ⠙ ⠹ ⠸ ⠼ ⠴ ⠦ ⠧ ⠇ ⠏],
    arrow: %w[← ↖ ↑ ↗ → ↘ ↓ ↙],
    bouncing: %w[⠁ ⠂ ⠄ ⠂]
  }

  def self.spinner(type = :classic)
    i = 0
    loop do
      print "\r#{SPINNERS[type][i % SPINNERS[type].length]}"
      sleep 0.1
      i += 1
    end
  end

  def self.clear_line
    print "\r#{' ' * 50}\r"
  end

  def self.load(type = :classic)
    t = Thread.new { spinner(type) }
    result = yield
    Thread.kill t
    clear_line
    result
  end
end

