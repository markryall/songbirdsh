module Songbirdsh
  class RangeExpander
    def expand text
      text.split(/[^0-9a-z-]/).inject([]) {|acc, term| acc + expand_term(term) }
    end
  private
    def expand_term term
      words = term.split '-'
      words.empty? ? [] : range(words.first, words.last)
    end

    def range from, to
      f, t = to_number(from), to_number(to)
      t = to_number(from.slice(0...from.size-to.size)+to) if t < f
      (f..t).to_a
    end

    def to_number term
      term.to_i 36
    end
  end
end