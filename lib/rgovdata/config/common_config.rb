# This module is used to include basic support to access
# the shared RGovData::Config instance
module RGovData::CommonConfig
  # Returns the current config instance
  def config
    RGovData::Config.instance
  end
end
