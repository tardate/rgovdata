# This module is used to include basic support to access
# the shared RGovData::Config instance
module RGovData::CommonConfig
  # Returns the current config instance
  def config
    RGovData::Config.instance
  end
  # Sets the requirement to have a config file
  # Must be called before config is invoked
  def require_config_file
    RGovData::Config.require_config_file
  end
end
