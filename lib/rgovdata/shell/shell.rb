class Rgovdata::Shell
  attr_accessor :options

  def initialize(options)
    @options = (options||{}).each{|k,v| {k => v} }
  end

  def run
    self.class.usage
  end

  OPTIONS = %w(help verbose json+ xml file=s url=s key=s secret=s ping type=s request=s id:s options=@s)
  def self.usage
    puts <<-EOS

rgovdata client v#{Rgovdata::Version::STRING}
===================================

Usage:
  rgd [options]

  
    EOS
  end
end