class Songbirdsh::Command::Reload
  def initialize library
    @library = library
  end

  def execute ignored=nil
    @library.reload
  end
end