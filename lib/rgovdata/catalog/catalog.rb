class RGovData::Catalog
  attr_accessor :realm
  
  def initialize(default_realm=nil)
    @realm = default_realm
  end

  # Returns available realms
  def realms
    # TODO: currently hard-coded
    [:sg,:us]
  end

  # Returns an array of ServiceListings for the current realm
  def services
    @services ||= registry_strategy.load_services
  end

  # override realm setter to clear state when realm changed
  def realm=(value)
    clear
    @realm = value
  end

  # Returns the registry strategy class for the current realm
  def registry_strategy
    RGovData::RegistryStrategy.instance_for_realm(realm)
  end
  protected :registry_strategy

  # Clears current state
  def clear
    @realm = @services = nil
  end
  protected :clear
end
