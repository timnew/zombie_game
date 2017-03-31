class Game
  class DSLError < RuntimeError
    attr_reader :line, :line_no

    def initialize(line, line_no)
      @line = line
      @line_no = line_no
    end

    def message
      'Invalid instruction'
    end

    def print_console
      puts "[#{Rainbow('Error').bright.red}] #{message}: [#{Rainbow(line_no).blue}] #{Rainbow(line).cyan}"
    end
  end
end
