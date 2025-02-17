require "./Lox.cr"
require "./Token.cr"

alias TT = TokenType

class Scanner
  # does current being a UInt32 means that any jlox source code
  # is limited by the size of current before it wraps backaround?
  property start   : UInt32 = 0
  property current : UInt32 = 0
  property line    : Int32  = 1
  property tokens = [] of Token

  def initialize(source : String) : Nil
    @source = source
  end

  def scan_tokens() : Array(Token)
    while !is_at_end?
      @start = @current
      scan_token()
    end

    tokens.push(Token.new(TT::EOF, "", nil, line))
    return tokens
  end

  private def scan_token() : Nil
    c : Char = advance()

    case c
    # single char tokens
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
    # single chars that could also be 2 char tokens
    when '!'
      add_token( match?('=') ? TT::BANG_EQUAL : TT::BANG )
    when '='
      add_token( match?('=') ? TT::EQUAL_EQUAL : TT::EQUAL )
    when '<'
      add_token( match?('=') ? TT::LESS_EQUAL : TT::LESS )
    when '>'
      add_token( match?('=') ? TT::GREATER_EQUAL : TT::GREATER )
    when '/'
      if match?('/')
        while (peek() != '\n' && !is_at_end?())
          advance()
        end
      else
        add_token(TT::SLASH)
      end
    when ' ', '\r', '\t'
    when '\n'
      @line += 1
    when '"'
      str()
    else
      if is_digit?(c)
        num()
      else
        Lox.error(line, "Un expected '.' character")
      end
    end
  end

  private def num() : Nil
    while is_digit?(peek())
      advance()
    end

    # look for fractional part
    if peek() == '.' && is_digit?(peek_next())
      # consume the '.'
      advance()
      while is_digit?(peek())
        advance()
      end
    end
    lit = @source[@start...@current].to_f64
    add_token(TT::NUMBER, lit)
  end

  private def str() : Nil
    while (peek() != '"' && !is_at_end?())
      @line += 1 if peek() == '\n'
      advance()
    end

    if is_at_end?()
      Lox.error(line, "Unterminated string")
      return
    end

    # closing '"'
    advance()

    # trim surrounding quotes
    value : String = @source[@start+1, @current-1]
    add_token(TT::STRING, value)
  end

  private def match?(expected : Char) : Bool
    if is_at_end?
      return false
    end
    if @source[@current] != expected
      return false
    end
    @current += 1
    return true
  end

  private def peek() : Char
    if is_at_end?()
      return '\0'
    end
    return @source[@current]
  end

  private def peek_next() : Char
    if @current+1 >= @source.size
      return '\0'
    end
    return @source[@current+1]
  end

  private def is_digit?(c : Char) : Bool
    return c >= '0' && c <= '9'
  end

  private def is_at_end?() : Bool
    return @current >= @source.size
  end

  private def advance() : Char
    c : Char = @source[@current]
    @current += 1
    return c
  end

  private def add_token(type : TokenType) : Nil
    add_token(type, nil)
  end

  private def add_token(type : TokenType, literal : LiteralType) : Nil
    text = @source[@start...@current]
    tokens.push(Token.new(type, text, literal, line))
  end
end
