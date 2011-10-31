class Rgovdata::RegistryStrategy
  attr_accessor :realm

  class << self
    # Returns the appropriate RegistryStrategy for the given realm
    # +realm+ is the required realm
    def instance_for_realm(realm)
      # TODO: this is where we can abstract different registry schemes
      # e.g by default we will look for a class called Rgovdata::<realm>Registry (Rgovdata::ZhRegistry)
      # else we take the default strategy
      # Currently this just defaults to internal registry:
      Rgovdata::InternalRegistry.new(realm)
    end
  end

  # +new+ accepts realm parameter
  def initialize(default_realm=nil)
    @realm = default_realm
  end

  # Returns the list of services for the realm
  def load_services
    []
  end

end