# A ServiceListing is the metadata describing a specific service
# It encapsulates access to the underlying service
class RGovData::Service
  include RGovData::CommonConfig
  include RGovData::Dn

  attr_reader :key
  attr_reader :uri,:type,:transport,:credentialset
  attr_reader :native_instance    # the underlying native service object (if applicable)

  class << self
    # Returns the appropriate Service class for the given uri and type
    # +uri+ is the uri (string)
    # +type+
    # +transport+
    # +credentialset+
    def get_instance(uri,type,transport,credentialset)
      service_class = "RGovData::#{type.to_s.capitalize}Service".constantize
      service_class.new(uri,type,transport,credentialset)
    rescue # invalid or not a supported type
      nil
    end
  end

  # +new+ requires
  # +uri+ url to the service interface
  # +type+ service type: :odata, :csv ..
  # +transport+ transport mechanism selector: :odata, :get
  # +credentialset+
  def initialize(uri,type,transport,credentialset)
    @uri,@type,@transport,@credentialset = uri,type,transport,credentialset
  end

  # Returns the native service object if applicable
  # By default, returns self
  def native_instance
    @native_instance || self
  end
  
  # Returns an array of DataSets (names) for the service
  def datasets
    []
  end

  # Returns the dataset(s) matching +key+
  def get_dataset(key)
    return nil unless datasets && !datasets.empty?
    matches = datasets.select {|s| s =~ /#{key}/}
    matches.count == 1 ? matches.first : matches
  end
  # Returns the first dataset matching +key+
  def find(id)
    Array(get_dataset(id)).first
  end
  # Alias for find
  alias_method :find_by_id, :find

end