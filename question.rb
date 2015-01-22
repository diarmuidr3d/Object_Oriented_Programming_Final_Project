class Question
  def initialize arg1, operator, arg2
    @arg1 = arg1
    @op = operator
    @arg2 = arg2
  end
  def evaluate
    if @op.eql? "+"
      @arg1 + @arg2
    elsif @op.eql? "-"
      @arg1 - @arg2
    elsif @op.eql? "*"
      @arg1*@arg2
    elsif @op.eql? "/"
      @arg1/@arg2
    end
  end
  def to_s
    "#{@arg1}#{@op}#{@arg2}"
  end
  def == question
    if self.evaluate == question.evaluate
      return true
    end
    return false
  end
end