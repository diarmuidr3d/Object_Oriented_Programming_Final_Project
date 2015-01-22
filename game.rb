require_relative 'player.rb'
class Game
  attr_reader :player #for testing
  attr_reader :total_score #for testing
  attr_reader :questions #for testing
  def initialize name, difficulty, seed, num_questions
    @num_questions = num_questions
    @total_score = 0
    @questions = Array.new
    @correct = Array.new
    @incorrect = Array.new
    @player = Player.new name, difficulty
    @number_generator = Random.new seed
    @operator_generator = Random.new seed
  end
  def get_questions
    generate_questions @player.difficulty, @num_questions
    @num_questions = @num_questions - 3
    return @questions
  end
  def list_questions
    list = ''
    @correct.each do |x|
      list = "#{list}What is #{x.to_s}? CORRECT\n"
    end
    @incorrect.each do |x|
      list = "#{list}What is #{x.to_s}? INCORRECT\n"
    end
    list = "#{list}Total Score: #{@total_score}"
    return list
  end
  def end_round answers
    compare = compare_answers answers
    if compare == 1
      @player.difficulty = @player.difficulty + 1
    elsif (compare == -1) && (@player.difficulty > 1)
      @player.difficulty = @player.difficulty - 1
    end
    ret = case @player.difficulty
      when 5 then return true
      else return false
          end
    if @num_questions < 1
      ret = true
    end
  end

  #############PRIVATE#################
  private
  #difficulty: 1=Basic, 2=Intermediate, 3=advanced, 4=master
  #it will generate a max of 3 questions, number of questions is only for the last few questions, when the player wants a number of questions that's not a multiple of 3
  def generate_questions difficulty, number_of_questions
    @questions.clear
    random_range = case difficulty
                     when 1, 3 then 9
                     else 99
                   end
    if number_of_questions > 3
      number_of_questions = 3
    elsif number_of_questions < 1
      number_of_questions  = 3
    end
    number_of_questions.times do
      @questions.push(Question.new((@number_generator.rand(random_range) + 1), generate_operator(difficulty), (@number_generator.rand(random_range) + 1)))
    end
  end
  def generate_operator difficulty
    operator_rand = @operator_generator.rand 2
    case difficulty
      when 1, 2
        case operator_rand
          when 0 then "+"
          else "-"
        end
      else
        case operator_rand
          when 0 then "*"
          else "/"
        end
    end
  end
  def compare_answers answers
    i = 0
    @questions.length.times do |x|
      if @questions.at(x).evaluate == answers.at(x)
        @correct.push @questions.at(x)
        @total_score = @total_score + @player.difficulty
        i = i + 1
      else
        @incorrect.push @questions.at(x)
        i = i - 1
      end
    end
    if i > 0
      return 1
    elsif i == 0
      return 0
    else
      return -1
    end
  end

end