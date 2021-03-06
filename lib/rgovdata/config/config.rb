require 'ostruct'
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

  attr_accessor :default_realm, :credentialsets

  def initialize
    load_default_config
  end

  # Reloads configuraiton from default config provider
  # - rails config file (if used in Rails)
  # - current directory
  # - environment settings
  def load_default_config
    clear
    # load default config
    if rails_root
      # if rails env, load from Rails.root.join('config',BASE_NAME)
      load_config(rails_root.join('config',BASE_NAME),self.class.default_loader_options)
    elsif
      # else load from pwd
      load_config(self.class.default_config_file,self.class.default_loader_options)
    else
      # else just refresh_from_env
      refresh_from_env
    end
  end
  # Returns the rails root, if the Rails environment is available
  def rails_root
    Rails.root if defined?(Rails)
  end
  protected :rails_root

  def load_config(configfilepath, options = {})
    options.reverse_merge!(:generate_default => true,:required => true)
    unless File.exists?(configfilepath)
      self.class.reset_configfile(configfilepath) if options[:generate_default]
      if File.exists?(configfilepath)
        raise ConfigurationFileInitialized.new("\n
No configuration file found.
A new file has been initialized at: #{configfilepath}
Please review the configuration and retry..\n\n\n")
      elsif options[:required]
        raise ConfigurationFileNotFound.new("cannot load config file #{configfilepath}")
      else
        return
      end
    end
    update_settings(OpenStruct.new(YAML::load(File.read(configfilepath))))
  end

  # Updates attributes from config, including env override
  # +config+ OpenStruct structure
  def update_settings(config)
    @credentialsets.merge!(config.credentialsets||{})
    @default_realm = config.default_realm.to_sym if config.default_realm
    refresh_from_env
  end
  protected :update_settings

  # Clears the current configuration
  def clear
    @credentialsets = {}
    @default_realm = nil
  end

  # Prints current status
  def show_status
    if credentialsets
      puts "credential sets available: #{credentialsets.keys.join(',')}"
      puts credentialsets.inspect
    else
      puts "credential sets available: none"
    end
  end
  
  # Sets environment overrides for supported settings
  def refresh_from_env
    if ENV['projectnimbus_account_key'] || ENV['projectnimbus_unique_user_id']
      @credentialsets['projectnimbus'] ||= {}
      @credentialsets['projectnimbus'].merge!({'AccountKey'=> ENV['projectnimbus_account_key']}) if ENV['projectnimbus_account_key']
      @credentialsets['projectnimbus'].merge!({'UniqueUserID'=> ENV['projectnimbus_unique_user_id']}) if ENV['projectnimbus_unique_user_id']
    end
    if ENV['rgovdata_username'] || ENV['rgovdata_password']
      @credentialsets['basic'] ||= {}
      @credentialsets['basic'].merge!({'username'=> ENV['rgovdata_username']}) if ENV['rgovdata_username']
      @credentialsets['basic'].merge!({'password'=> ENV['rgovdata_password']}) if ENV['rgovdata_password']
    end
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

    def default_loader_options
      @@default_loader_options ||= {:generate_default => false,:required => false}
    end
    
    def require_config_file
      @@default_loader_options = {:generate_default => true,:required => true}
    end
  end
  
end
