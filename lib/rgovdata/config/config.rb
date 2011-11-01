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

  attr_accessor :credentialsets

  def initialize
    clear
    # load default config
    refresh_from_env
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
    config = RGovData::YamlConfig.new(configfilepath)
    @credentialsets.merge!(config.config["credentialsets"])
    refresh_from_env
  end

  # Clears the current configuration
  def clear
    @credentialsets = {}
  end
  
  # Sets environment overrides for supported settings
  def refresh_from_env
    @credentialsets.merge!('projectnimbus' => {'AccountKey'=> ENV['projectnimbus_account_key']}) if ENV['projectnimbus_account_key']
    @credentialsets.merge!('projectnimbus' => {'UniqueUserID'=> ENV['projectnimbus_unique_user_id']}) if ENV['projectnimbus_unique_user_id']
    @credentialsets.merge!('basic' => {'username'=> ENV['rgovdata_username']}) if ENV['rgovdata_username']
    @credentialsets.merge!('basic' => {'password'=> ENV['rgovdata_password']}) if ENV['rgovdata_password']
  end
  protected :refresh_from_env
  
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

    def template_path
      RGovData::Template.path('config_template.yml')
    end
  end
  
end
