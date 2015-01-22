require 'test/unit'
require_relative 'game.rb'
class TC_Game < Test::Unit::TestCase
  def setup
    @g = Game.new 'John', 1, 1234, 3
  end
  def test_initialize
    assert(@g.player.name.to_s.eql?('John'), "Name initialised incorrectly")
    assert_equal(@g.player.difficulty, 1, "Difficulty Initialised incorrectly")
  end
  def test_end_round
    3.times do
      @questions = @g.get_questions
      @answers = @questions.map {|x| x.evaluate}
      assert_equal(@g.end_round(@answers), false, "End round not returning false correctly")
    end
    @questions = @g.get_questions
    @answers = @questions.map {|x| x.evaluate}
    assert_equal(@g.end_round(@answers), true, "End round not returning true correctly")
  end
  def test_list_questions
    @questions = @g.get_questions
    @answers = [-3, 1, 4]
    @g.end_round(@answers)
    assert(@g.list_questions.eql?("What is 4-7? CORRECT\nWhat is 6-5? CORRECT\nWhat is 9+2? INCORRECT\nTotal Score: 2"), "List Questions Incorrect")
  end
  def test_total_score
    @questions = @g.get_questions
    @answers = [-3, 1, 4]
    @g.end_round(@answers)
    assert_equal(@g.total_score, 2, "Total Score Incorrect")
  end
  def test_generate_basic
    @questions = @g.get_questions
    assert(@questions.at(0).to_s.eql?('4-7'), "Error Generating basic question 1")
    assert(@questions.at(1).to_s.eql?('6-5'), "Error Generating basic question 2")
    assert(@questions.at(2).to_s.eql?('9+2'), "Error Generating basic question 3")
  end
  def test_generate_less_q
    @g = Game.new 'John', 1, 1234, 2
    @questions = @g.get_questions
    assert(@questions.at(0).to_s.eql?('4-7'), "Less Q: Error Generating basic question 1")
    assert(@questions.at(1).to_s.eql?('6-5'), "Less Q: Error Generating basic question 2")
    assert_equal(@questions.at(2), nil, "Less Q: Generating too many")
  end
  def test_generate_master
    @g = Game.new 'John', 4, 1234, 3
    @questions = @g.get_questions
    assert(@questions.at(0).to_s.eql?('48/84'), "Error Generating master question 1")
    assert(@questions.at(1).to_s.eql?('39/54'), "Error Generating master question 2")
    assert(@questions.at(2).to_s.eql?('77*25'), "Error Generating master question 3")
  end
end