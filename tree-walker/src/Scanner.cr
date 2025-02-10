require "./Token.cr"

class Scanner

  private getter start   : UInt32 = 0
  private getter current : UInt32 = 0
  private getter line    : UInt32 = 1

  def initialize(source : String) : Nil
    @source = source
  end

  def scan_tokens() : Array(Token)
    a = [Token.new(TokenType::COMMA, "var", 1)]

    case c
    when v1
    when v2
    else
      # default
    return a
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

s = Scanner.new("byte stream?")
p! s.scan_tokens()
