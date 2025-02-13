require "./Scanner.cr"
# i did not want to make a main class but
# the hadError field, requires a global var
# if you do this w/o OOP
class Lox
  # @@var makes it static?
  # dont see need to make it static if only one instance of the TreeWalker
  @@had_error : Bool = false

  def main() : Nil
    if ARGV.size > 1
      puts "Usage: jlox [script]"
      exit(64)
    elsif ARGV.size == 1
      run_file(ARGV[0])
    else
      run_prompt()
    end
  end

  private def run_file(path : String) : Nil

    if !File.file?(path)
      puts "#{path} does not exist"
      exit(64)
    end

    file = File.read(path)
    run(file)
    exit(65) if @had_error
  end

  private def run_prompt() : Nil
    line : String
    while true
      print "> "
      line = gets() || ""

      break if line.empty?
      run(line)
      @had_error = false
    end
  end

  private def run(source : String) : Nil
    s = Scanner.new(source)
    tokens : Array(Token) = s.scan_tokens()
    tokens.each do |tok|
      p! tok
    end
  end

  def self.error(line : Int32, message : String) : Nil
    report(line, "", message)
  end

  # so public static methods cant call private methods because
  # private methods are instance level, work around is to make both private/public and static
  private def self.report(line : Int32, where : String, message : String) : Nil
    puts("[line #{line}] Error#{where}: #{message}")
    @@had_error = true
  end
end

interpreter = Lox.new()
interpreter.main()
