require_relative 'question.rb'
require 'test/unit'
class TC_Question < Test::Unit::TestCase
  def setup
    @a = Question.new 6, "+", 2
    @b = Question.new 6, "-", 2
    @c = Question.new 6, "*", 2
    @d = Question.new 6, "/", 2
  end
  def test_to_s
    assert(@a.to_s.eql?("6+2"), "To_s incorrect")
  end
  def test_evaluate
    assert_equal(@a.evaluate, 8, "Incorrect Eval: +")
    assert_equal(@b.evaluate, 4, "Incorrect Eval: -")
    assert_equal(@c.evaluate, 12, "Incorrect Eval: *")
    assert_equal(@d.evaluate, 3, "Incorrect Eval: /")
  end
  def test_eql
    @e = Question.new(6, "+", 2)
    assert(@a == @e, "== Incorrect Comparing Same")
    assert(!(@b == @c), "== Incorrect Comparing Different")
  end
end