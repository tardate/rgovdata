# RGovData::Catalog is the main entry point for service discovery
#
class RGovData::Catalog
  attr_accessor :realm
  include RGovData::CatalogItem

  class << self
    # Returns the object specified by the +key+
    #
    # Key specification:
    # * //<realm>/<service-key>/<data-set-name>
    #
    # All key components are optional - you will get the best matching object for the key spec
    # * //sg - will return RGovData::Catalog for realm=:sg
    # * //sg/nlb - will return RGovData::ServiceListing for the nlb service in SG
    # * /nlb - will return RGovData::ServiceListing for the nlb service in SG (assuming SG is the default realm)
    # * //sg/nlb/Library - will return RGovData::OdataService for the nlb Library service in SG
    #
    def get(key)
      key ||= '//'
      key.gsub!(':','/') # handle alternate encoding
      keypart = Regexp.new(/(?:\/\/([^\/]+))?(?:\/([^\/]+))?(?:\/([^\/]+))?/).match(key)
      found = catalog = self.new(keypart[1])
      if keypart[2]
        found = service = catalog.find_by_key(keypart[2])
        if keypart[3]
          found = service.find_by_key(keypart[3])
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
    RGovData::RegistryStrategy.available_realms.map { |realm| self.class.new(realm) }
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

  # Alias +key+ to +realm+ for master catalog level items.
  alias_method :key, :realm

  # Returns the registry strategy instance for the current realm
  def registry_strategy
    RGovData::RegistryStrategy.get_instance(realm)
  end
  protected :registry_strategy
  
  # Generic interface to return the currently applicable record set
  #
  # Overrides RGovData::CatalogItem#records
  def records
    if realm.present?
      services
    else
      realms
    end
  end

  # Clears current state.
  # TODO: move to CatalogItem?
  def clear
    @realm = @services = nil
  end
  protected :clear
end
