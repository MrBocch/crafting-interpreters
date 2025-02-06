require "./TokenType.cr"

class Token
  # constants seem so finiky in crystal
  # why cant declare constant vars when initialize?
  def initialize(type : TokenType, lexeme : String, line : Int32)
    @type = type
    @lexeme = lexeme
    @line = line
  end

  def to_s() : String
    "#{@type} #{@lexeme} {idk what is a literal}"
  end

end

t = Token.new(TokenType::COMMA, "var", 32)
p! t.to_s
