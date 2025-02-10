require "./Token.cr"

alias TT = TokenType

class Scanner

  property start   : UInt32 = 0
  property current : UInt32 = 0
  property line    : Int32  = 1
  # crystal can feel so backwards at times, is skill issue?
  # property tokens : Array(Token) = []
  property tokens = [] of Token

  def initialize(source : String) : Nil
    @source = source
  end

  def scan_tokens() : Array(Token)
    while !is_at_end?
      start = current
      scan_token()
    end

    tokens.push(Token.new(TT::EOF, "", line))
    return tokens
  end

  private def scan_token() : Nil
    c : Char = advance()

    case c
    when '(' then add_token(TT::LEFT_PAREN)
    when ')' then add_token(TT::RIGHT_PAREN)
    when '{' then add_token(TT::LEFT_BRACE)
    when '}' then add_token(TT::RIGHT_BRACE)
    when ',' then add_token(TT::COMMA)
    when '.' then add_token(TT::DOT)
    when '-' then add_token(TT::MINUS)
    when '+' then add_token(TT::PLUS)
    when ';' then add_token(TT::SEMICOLON)
    when '*' then add_token(TT::STAR)
    else
      # how do i call this thing ?
      # TreeWalker.error("unexpected character")
      puts "Error, #{line}"
      exit(64)
    end
  end

  private def add_token(type : TokenType) : Nil
    # dont know what the object literal stuff is about
    text = @source[start...current]
    tokens.push(Token.new(type, text, line))
  end


  private def advance() : Char
    # not check if aoutof bounds?
    c : Char = @source[current]
    @current += 1
    # i never liked x++ , ++x, increments
    # but its so unclear, sometimes
    return c
  end

  private def is_at_end?() : Bool
    # weird that there is no issues
    # when current and source.size are different types
    # what exactly is it doing?
    # https://crystal-lang.org/api/1.15.1/UInt32.html#%3E%3D%28other%3AInt32%29%3ABool-instance-method
    # String.size : Int32 , its interesting
    # a string could only be of size 0 to length
    # why not use unsigned integer?
    return current >= @source.size
  end
end

s = Scanner.new("(-a")
p! s.scan_tokens()
