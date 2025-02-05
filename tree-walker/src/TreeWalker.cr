# i did not want to make a main class but
# the hadError field, requires a global var
# if you do this w/o OOP
class TreeWalker
  def main() : Nil
    if ARGV.size > 1
      puts "Usage: jlox [script]"
      exit(64)
    elsif ARGV.size == 1
      runFile(ARGV[0])
    else
      runPrompt()
    end
  end

  private def runFile(path : String) : Nil

    if !File.file?(path)
      puts "#{path} does not exist"
      exit(64)
    end

    file = File.read(path)
  end

  private def runPrompt() : Nil
    line : String
    while true
      print "> "
      line = gets() || ""

      break if line.empty?
      run(line)
    end
  end

  private def run(source : String) : Nil
    # s = scanner.new
    # tokens : Array(Token) = s.scanTokens()
    # tokens.each do |tok|
    #   puts tok
    # end
  end

  private def error(line : Int32, message : String) : Nil
    report(line, "", message)
  end

  private def report(line : Int32, where : String, message : String) : Nil
    puts("[line #{line}] Error#{where}: #{message}")
    hadError : Bool = true
  end
end

interpreter = TreeWalker.new()
interpreter.main()
