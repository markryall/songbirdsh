require 'yaml'
require 'songbirdsh/command'

class Songbirdsh::Command::Enqueue < Songbirdsh::Command
  def execute text
    terms = text.split(/[^0-9a-z-]/)
    values = terms.inject([]) {|acc, term| acc + expand(term)}
    values.each {|id| @player.enqueue id }
  end

  def usage
    '*<id>'
  end

  def help
    'enqueues the list of songs with the specified ids'
  end
private
  def expand term
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