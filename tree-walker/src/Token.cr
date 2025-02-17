require "./TokenType.cr"

# had to look this up
# https://github.com/rebeccabuckingham/crystal-craftinginterpreters/blob/a48153704b66ee6ba030a02bf475383f5b5db2a4/src/crlox/token.cr#L3
# are generics T ment to replace this?
alias LiteralType = (Int32 | String | Char | Float64 | Nil)

class Token
  property type
  property lexeme
  property literal
  property line

  def initialize(type : TokenType,
                lexeme : String,
                literal : LiteralType,
                line : Int32) : Nil
    @type = type
    @lexeme = lexeme
    @literal = literal
    @line = line
  end

  def to_s() : String
    "#{@type} #{@lexeme} #{@literal} #{@line}"
  end

end
