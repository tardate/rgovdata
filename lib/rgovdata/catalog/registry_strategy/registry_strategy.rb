# RegistryStrategy is the abstract base class that represents the various strategies
# that may be used by rgovdata.
#
# RGovData::InternalRegistry is the fallback strategy. Ideally we should not be relying
# on this too much, as it means we need to carry around all the service definitions as part of the gem.
# But, in the absence of external directory integration, it is a necessary evil.
#
# To contribute a registry strategy for a specific realm, add a new class called
# RGovData::<realm>Registry, descended from RGovData::RegistryStrategy.
# Internally, it can do whatever it needs to do in order to query/cache the service.
# Also add your realm name to RGovData::RegistryStrategy##available_realms if not already included.
#
class RGovData::RegistryStrategy
  attr_accessor :realm

  class << self
    # Returns the appropriate RegistryStrategy for the given realm.
    # * +realm+ - requests the stratey for this realm
    #
    # By default we will look for a class called RGovData::<realm>Registry (e.g. Rgovdata::ZhRegistry)
    # and fallback to RGovData::InternalRegistry when no other registry available.
    def get_instance(realm)
      service_class = "RGovData::#{realm.to_s.capitalize}Registry".constantize
      service_class.new(realm)
    rescue # invalid or not a supported type - fallback to RGovData::InternalRegistry
      RGovData::InternalRegistry.new(realm)
    end

    # Returns an Array of available realms
    def available_realms
      [:sg,:us]
    end
  end

  # Initialise the strategy
  # * +realm+ the string or symbol name for the realm
  def initialize(realm=nil)
    @realm = realm
  end

  # Returns an array of services for the realm.
  # Override this for each specific registry strategy
  def load_services
    []
  end

end