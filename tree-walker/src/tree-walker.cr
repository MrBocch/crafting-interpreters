def main
  if ARGV.size > 1
    puts "Usage: jlox [script]"
    exit(64)
  elsif ARGV.size == 1
    runFile(ARGV[0])
  else
    runPrompt()
  end
end

def runFile(path : String) : Nil

  if !File.file?(path)
    puts "#{path} does not exist"
    exit(64)
  end

  file = File.read(path)
  # run file
end

def runPrompt() : Nil
  line : String
  while true
    print "> "
    line = gets() || ""

    break if line.empty?
    run(line)
  end
end

def run(source : String) : Nil

end

main
