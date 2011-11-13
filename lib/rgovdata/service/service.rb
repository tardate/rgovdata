require 'ostruct'

# A Service describes a specific service
# It encapsulates access to the underlying service implementation
class RGovData::Service
  include RGovData::CommonConfig
  include RGovData::CatalogItem
  
  attr_accessor :options
  attr_reader :native_instance    # the underlying native service object (if applicable)

  class << self
    # Returns the appropriate Service class for the given uri and type
    # +options may be a RGovData::ServiceListing or a Hash
    # If +options+ is a hash, it requires the following members:
    # +uri+
    # +type+
    # +credentialset+
    def get_instance(options={})
      type = (options.class <= RGovData::ServiceListing) ? options.type : options[:type]
      service_class = "RGovData::#{type.to_s.capitalize}Service".constantize
      service_class.new(options)
    rescue # invalid or not a supported type
      nil
    end
  end

  # +new+ requires +options which may be a RGovData::ServiceListing or a Hash.
  # If +options+ is a hash, it requires the following members as minimum:
  # * +uri+
  # * +type+
  # * +credentialset+
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

  # Returns array of attributes that describe the specific entity
  #
  # Overrides RGovData::CatalogItem#meta_attributes
  def meta_attributes
    [:id,:realm,:service_key,:uri,:type,:transport,:credentialset]
  end

  # Returns the native service object if applicable.
  # By default, returns self.
  def native_instance
    @native_instance || self
  end
  
  # Returns an array of DataSets for the service.
  # May need to be overridden for a specific service type.
  def datasets
    dataset_class = "RGovData::#{type.to_s.capitalize}DataSet".constantize
    @datasets ||= dataset_class.load_datasets(self)
  rescue
    []
  end

  # Returns an array of DataSets (keys) for the service.
  # Needs to be overridden for each service type.
  def dataset_keys
    []
  end
  
end