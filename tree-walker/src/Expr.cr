require "./Token.cr"

abstract class Expr
  def initialize()
  end
end

class Binary < Expr
  def initialize(left : Expr, operator : Token, right : Expr)
    @left = left
    @operator= operator
    @right = right
  end
end
