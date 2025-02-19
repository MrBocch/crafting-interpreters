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

  # crystal can feel so backwards sometimes
  # why cant keywords : Hash(String, TT) ?
  # property keywords = Hash(String, TT).new()
  # check this out
  property keywords = {
    "and"    => TT::AND,
    "class"  => TT::CLASS,
    "else"   => TT::ELSE,
    "false"  => TT::FALSE,
    "true"   => TT::TRUE,
    "for"    => TT::FOR,
    "fun"    => TT::FUN,
    "if"     => TT::IF,
    "nil"    => TT::NIL,
    "or"     => TT::OR,
    "print"  => TT::PRINT,
    "return" => TT::RETURN,
    "super"  => TT::SUPER,
    "this"   => TT::THIS,
    "true"   => TT::TRUE,
    "var"    => TT::VAR,
    "while"  => TT::WHILE
  }of String => TokenType

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
      elsif match?('*')
        multi_line_comment()
        @current += 1 # i should not have to do this, its so bad
        # findout why it would not pass over the '/'
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
      elsif is_alpha?(c)
        identifier()
      else
        Lox.error(line, "Un expected #{c} character")
      end
    end
  end

  private def identifier() : Nil
    while is_alpha_numeric?(peek())
      advance()
    end
    text : String = @source[@start, @current]
    type : TT = @keywords.has_key?(text) ? @keywords[text] : TT::IDENTIFIER
    add_token(type)
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

  private def multi_line_comment() : Nil
    # works perfectly when you close comments corretly
    # when they dont, you need to exit gracefully, without letting a method try to access outside array
    level : Int32 = 0
    begin_coment_line : Int32 = @line
    while !is_at_end?()
      case peek()
      when '*'
        # this is a case were if compiler were more strict about comparing different types
        # would have saved me time
        # level -= 1 if peek_next() == "/"
        level -= 1 if peek_next() == '/'
      when '/'
        level += 1 if peek_next() == '*'
      when '\n'
        @line += 1
      else
      end
      advance() # i keep forgeting to advance lool
      return if level < 0
    end
    Lox.error(begin_coment_line, "Forgot to close comment beggining here")
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

  private def is_alpha?(c : Char) : Bool
  return c.ascii_letter? || c == '_'
  # return (c >= 'a' && c <= 'z') ||
          #(c >= 'A' && c <= 'Z') ||
          # c == '_'
  end

  private def is_digit?(c : Char) : Bool
    return c.ascii_number?
    #return c >= '0' && c <= '9'
  end

  private def is_alpha_numeric?(c : Char) : Bool
    return c.ascii_alphanumeric?
    # return is_alpha?(c) || is_digit?(c)
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
