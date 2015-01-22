require_relative 'game.rb'
class ArithmeticTutor
  @difficulty = 1
  file = File.open 'tutor.dat'
  @input = Array.new
  file.each_line do |line|
    line = line.strip
    @input.push line
  end
  @name = @input[0]
  @num_questions = @input[1].to_i
  if @num_questions < 1
    @num_questions = 15
  end
  @seed = @input[2].to_i
  @game = Game.new @name, @difficulty, @seed, @num_questions
  @finished = false
  while !@finished && (@num_questions > 0)
    @questions = @game.get_questions
    @answers = Array.new
    @questions.each do |x|
      print "What is "+x.to_s+"?"
      @answers.push gets.strip.to_i
    end
    @finished = @game.end_round @answers
    @num_questions = @num_questions - 3
  end
  puts @game.list_questions
end