# This is the catalog class that describes an OData Service DataSet
class RGovData::OdataDataSet < RGovData::DataSet
  attr_reader :options
  attr_reader :service
  attr_reader :native_service
  
  class << self
    def load_datasets(service)
      ds = []
      service.dataset_keys.each do |dataset|
        ds << RGovData::OdataDataSet.new({:dataset_key=>dataset},service)
      end
      ds
    end
  end

  def initialize(options,service)
    @options = if options.is_a?(Hash)
      OpenStruct.new(options)
    else
      OpenStruct.new
    end
    @service = service.dup # avoid circular dependencies
    @native_service = @service.native_instance
  end

  # attribute accessors
  
  def realm           ; service.realm               ; end
  def service_key     ; service.service_key         ; end
  def dataset_key     ; options.dataset_key         ; end
  def top             ; options.top                 ; end
  def top=(value)
    options.top = value
  end

  # Returns array of attributes that describe the specific entity
  # => overrides RGovData::Dn.meta_attributes
  def meta_attributes
    [:id,:realm,:service_key,:dataset_key]
  end

  # Returns the native dataset key
  def native_dataset_key
    # TODO: is this generally true for OData??
    "#{dataset_key}Set"
  end

  # Returns the native OData::QueryBuilder
  # If +reload+ is true, it re-initializes the query builder
  def native_instance(reload = false)
    @native_instance = if reload
      load_instance
    else
      @native_instance || load_instance
    end
  end

  # Returns the attribute names based on class meta-data
  # => overrides RGovData::Dn.attributes
  def attributes
    @attributes ||= native_service.class_metadata[dataset_key].keys
  end

  # Returns the records
  # If +reload+ is true, it re-initializes and re-runs the query
  def records(reload = false)
    @records = if reload
      load_records
    else
      @records || load_records
    end
  end

  # Loads the native OData::QueryBuilder
  def load_instance
    native_service.send(native_dataset_key)
  end
  protected :load_instance

  # Loads the native record set
  def load_records
    native_instance(true)
    native_instance.top(top) if top.present?
    service.native_instance.execute
  end
  protected :load_records
end