class Player
  attr_accessor :difficulty
  attr_reader :name
  def initialize name, difficulty
    @name = name
    @difficulty = difficulty
  end
end