class RGovData::Catalog
  attr_accessor :realm

  class << self
    # Returns the object specified by the +key+
    # Key specification:
    # //<realm>/<service-key>/<data-set-name>
    # All key components are optional - you will get the best matching object for the key spec
    # //sg - will return RGovData::Catalog for realm=:sg
    # //sg/nlb - will return RGovData::ServiceListing for the nlb service in SG
    # /nlb - will return RGovData::ServiceListing for the nlb service in SG (assuming SG is the default realm)
    # //sg/nlb/Library - will return RGovData::ODataService for the nlb Library service in SG
    def get(key)
      found = nil
      keypart = Regexp.new(/(?:\/\/([^\/]+))?(?:\/([^\/]+))?(?:\/([^\/]+))?/).match(key)
      if keypart[1]
        found = catalog = self.new(keypart[1])
        if keypart[2]
          found = service = catalog.get_service(keypart[2])
          if keypart[3]
            found = service.get_dataset(keypart[3])
          end
        end
      end
      found
    end
  end

  def initialize(default_realm=nil)
    @realm = default_realm && default_realm.to_sym
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

  # Returns the service(s) matching +key+
  def get_service(key)
    return nil unless services && !services.empty?
    matches = services.select {|s| s.key =~ /#{key}/}
    matches.count == 1 ? matches.first : matches
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
