require "./TokenType.cr"

class Token
  # constants seem so finiky in crystal
  # why cant declare constant vars when initialize?

  # idk what the Object literal type will be for
  # or what would be comparable in crystal
  def initialize(type : TokenType, lexeme : String, line : Int32) : Nil
    @type = type
    @lexeme = lexeme
    @line = line
  end

  def to_s() : String
    "#{@type} #{@lexeme} {idk what is a literal} #{@line}"
  end

end
