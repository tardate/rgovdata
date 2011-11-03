require 'ostruct'

# A Service describes a specific service
# It encapsulates access to the underlying service implementation
class RGovData::Service
  include RGovData::CommonConfig
  include RGovData::Dn
  ATTRIBUTES = [:realm,:service_key,:uri,:type,:transport,:credentialset]

  attr_accessor :options
  attr_reader :native_instance    # the underlying native service object (if applicable)

  class << self
    # Returns the appropriate Service class for the given uri and type
    # +options may be a RGovData::ServiceListing or a Hash
    # If +options+ is a hash, it requires the following members:
    # +uri+
    # +type+
    # +transport+
    # +credentialset+
    def get_instance(options={})
      type = (options.class <= RGovData::ServiceListing) ? options.type : options[:type]
      service_class = "RGovData::#{type.to_s.capitalize}Service".constantize
      service_class.new(options)
    rescue # invalid or not a supported type
      nil
    end
  end

  # +new+ requires
  # +options may be a RGovData::ServiceListing or a Hash
  # If +options+ is a hash, it requires the following members:
  # +uri+
  # +type+
  # +transport+
  # +credentialset+
  def initialize(options)
    @options = if options.is_a?(Hash)
      OpenStruct.new(options)
    elsif options.class <= RGovData::ServiceListing
      options.dup # avoid circular refs
    else
      OpenStruct.new
    end
  end

  # attribute accessors
  def realm         ; options.realm         ; end
  def service_key   ; options.service_key   ; end
  def uri           ; options.uri           ; end
  def type          ; options.type          ; end
  def transport     ; options.transport     ; end
  def credentialset ; options.credentialset ; end

  def attributes
    ATTRIBUTES
  end

  # Returns a hash that fully describes this service and can be used as a parameter to +new+
  def initialization_hash
    h = {}
    attributes.each do |attribute|
      h.merge!(attribute => self.send(attribute))
    end
    h
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