# A ServiceListing is the metadata describing a specific service
# It encapsulates access to the underlying service
class RGovData::Service
  attr_reader :uri,:type,:transport,:credentialset

  class << self
    # Returns the appropriate Service class for the given uri and type
    # +uri+ is the uri (string)
    # +type+
    # +transport+
    def get_instance(uri,type,transport,credentialset)
      case type && type.to_sym
      when :odata
        RGovData::ODataService.new(uri,type,transport,credentialset)
      when :csv
        RGovData::CsvService.new(uri,type,transport,credentialset)
      else # not a supported type
        nil
      end
    end
  end

  # +new+ requires
  # +uri+ url to the service interface
  # +type+ service type: :odata, :csv ..
  # +transport+ transport mechanism selector: :odata, :get
  # +credentialset+
  def initialize(uri,type,transport,credentialset)
    @uri,@type,@transport,@credentials = uri,type,transport,credentialset
  end

  # Returns an Array of attributes supported by the service
  # By default, it is nil - which means the attributes are indeterminate
  def attributes
  end

  # Returns an array of DataSets (names) for the service
  def datasets
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