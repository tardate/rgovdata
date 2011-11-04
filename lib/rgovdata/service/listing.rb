# A ServiceListing is the metadata describing a specific service
# It encapsulates access to the underlying service
class RGovData::ServiceListing
  attr_accessor :realm         # realm for the service
  attr_accessor :key           # unique service name or id (within realm)
  attr_accessor :name          # human name of the service
  attr_accessor :description   # human description of the service
  attr_accessor :keywords      # keywords for the service
  attr_accessor :publisher     # service publisher name
  attr_accessor :license       # license covering the service if any
  attr_accessor :info_uri      # url to a web page about the service if any
  attr_accessor :uri           # url to the service interface
  attr_accessor :type          # service type [:odata,:csv,:file]
  attr_accessor :credentialset # name of the credential set required

  include RGovData::Dn

  # Returns the collection of services for this listing
  def service
    @service ||= RGovData::Service.get_instance(self)
  end

  # Returns the service key
  alias_method :service_key, :key

  # Returns an array of DataSets for the service
  # => delegate to service
  def datasets
    service.try(:datasets)
  end

  # Returns the dataset(s) matching +key+
  # => delegate to service
  def get_dataset(key)
    service.try(:get_dataset,key)
  end
  # Returns the first dataset matching +key+
  # => delegate to service
  def find(id)
    service.try(:find,id)
  end
  # Alias for find
  alias_method :find_by_id, :find
  

end