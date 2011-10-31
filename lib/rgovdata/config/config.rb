require 'singleton'
class RGovData::Config
  include Singleton
  BASE_NAME = 'rgovdata.conf'

  class ConfigError < StandardError
	end
  class ConfigurationFileNotFound < ConfigError
	end
  class ConfigurationFileInitialized < ConfigError
	end
	
  def load_config(configfilepath, generate_default_if_not_found = true)
    unless File.exists?(configfilepath)
      self.class.reset_configfile(configfilepath) if generate_default_if_not_found
      if File.exists?(configfilepath)
        raise ConfigurationFileInitialized.new("\n
No configuration file found.
A new file has been initialized at: #{configfilepath}
Please review the configuration and retry..\n\n\n")
      else
        raise ConfigurationFileNotFound.new("cannot load config file #{configfilepath}")
      end
    end
    # super(configfilepath)
  end

  # Clears the current configuration
  def clear
    
  end
  
  class << self
    def reset_configfile(configfilepath)
      file = File.new(configfilepath,'w')
      template.each_line do | line|
        file.puts line
      end
      file.close
    end

    def default_config_file(override = nil)
      File.expand_path(override || BASE_NAME)
    end
    
    def template
      RGovData::Template.get('config_template.yml')
    end
  end
  
end
