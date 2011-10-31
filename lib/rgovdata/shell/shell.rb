class Rgovdata::Shell
  attr_accessor :options

  # command line options definition
  OPTIONS = %w(help verbose)
  # Usage message
  def self.usage
    puts <<-EOS

rgovdata client v#{Rgovdata::Version::STRING}
===================================

Usage:
  rgd [options]

  
    EOS
  end

  # +new+
  def initialize(options)
    @options = (options||{}).each{|k,v| {k => v} }
  end

  # run the basic REPL
  def run( prompt = 'rgd> ' )
    welcome
    repl = lambda do |prompt|
      print prompt
      evaluate( STDIN.gets.chomp! )
    end
    loop { break unless repl[prompt] }
  end

  protected

  # Evaluates a specific command
  def evaluate(cmd)
    if cmd =~ /exit/i
      puts "bfn!\n\n"
      return false
    end
    begin
      tokens = cmd.strip.split
      return true unless tokens.size>0
      self.send tokens.shift.downcase, tokens
    rescue => e
      puts "sorry, I have a problem doing \"#{cmd}\"\nerror => #{e}"
      puts e.backtrace if options[:trace]
    end
    return true
  end
  
  # Print usage details
  def help(*args)
    self.class.usage
  end

  # Print welcome message
  def welcome(*args)
    puts <<-EOS

rgovdata client v#{Rgovdata::Version::STRING}. Type 'help' for info...
    EOS
  end

end