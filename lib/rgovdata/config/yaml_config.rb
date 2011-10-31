require 'yaml'

class RGovData::YamlConfig
  attr_reader :filename, :config
  class UninitializedValueError < StandardError
	end
  def initialize(filepath)
    @filename = filepath
    @config = YAML::load(File.read(filename))
  end
  def [](key)
    self.send( key )
  end
  def method_missing(name, *args)
    token=name.to_s
    default = args.length>0 ? args[0] : ''
    must_be_defined = default == :none
    value=config[token]
    value || ( must_be_defined ? (raise UninitializedValueError.new) : default )
  end
end