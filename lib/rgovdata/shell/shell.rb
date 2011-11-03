class RGovData::Shell
  include RGovData::CommonConfig
  attr_accessor :options, :prompt
  attr_accessor :discovery_path

  # command line options definition
  OPTIONS = %w(help verbose command=@s)
  # Usage message
  def self.usage
    puts <<-EOS

rgovdata client v#{RGovData::Version::STRING}
===================================

Usage:
  rgd [options]

Command Options
  -c | --command    immediately executes the command provided

The following commands are supported in the rgovdata shell.
They can also be passed on the command line:

  rgd -c command
  
  == Core Commands ==
  help
  exit
  show status

  == Discovery Commands ==
  ls
  cd
  info

    EOS
  end

  # +new+
  def initialize(options)
    @options = (options||{}).each{|k,v| {k => v} }
    @discovery_path = [config.default_realm].compact
  end

  # run the basic REPL
  def run
    if options[:command].present?
      evaluate options[:command].join(' ')
      return
    end
    welcome
    repl = lambda do |prompt|
      print prompt
      evaluate( STDIN.gets.chomp! )
    end
    loop { break unless repl[prompt] }
  end

  # Update and return the formatted prompt
  def prompt
    @prompt = "rgd:#{current_path}> "
  end
  def current_path
    "//#{discovery_path.join('/')}"
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

rgovdata client v#{RGovData::Version::STRING}. Type 'help' for info...
    EOS
  end

  # Prints current status
  def show_status
    puts "shell options: #{options.inspect}"
  end

  # handle show command
  def show(args=[])
    cmd = args.shift || "help"
    
    case cmd
    when /^set/i
      set(args)
    when /^status?$/i
      status(args)
    else
      help
    end
  end

  # handle status command
  def status(args=[])
    show_status
    config.show_status
  end

  # handle ls command
  def ls(args=[])
    
  end

  # handle cd command
  def cd(args=[])
    cmd = args.shift || "ls"
    case cmd
    when '..'
      discovery_path.pop
    when /^ls$/i
      ls
    else
      discovery_path.push(*cmd.split('/'))
    end
  end

end