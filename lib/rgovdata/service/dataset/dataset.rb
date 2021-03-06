# This is the catalog class that describes a generic Service DataSet
class RGovData::DataSet
  include RGovData::CatalogItem
  attr_reader :options
  attr_reader :service
  attr_reader :native_service

  class << self
    def load_datasets(service)
      dataset_class = "RGovData::#{service.type.to_s.capitalize}DataSet".constantize
      ds = []
      service.dataset_keys.each do |dataset|
        ds << dataset_class.new({:dataset_key=>dataset},service)
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
    @native_service = @service.try(:native_instance)
  end

  # attribute accessors
  def realm           ; service.realm               ; end
  def service_key     ; service.service_key         ; end
  def dataset_key     ; options.dataset_key         ; end
  def uri             ; service.uri                 ; end
  # Returns the record limit currently imposed
  def limit           ; options.limit               ; end
  # Set the record limit to +value+
  def limit=(value)
    options.limit = value
  end

  # Returns array of attributes that describe the specific entity.
  #
  # Overrides RGovData::CatalogItem.meta_attributes
  def meta_attributes
    [:id,:realm,:service_key,:dataset_key]
  end

  # Returns the native dataset key.
  alias_method :key, :dataset_key

  # Returns the native dataset instance.
  # If +reload+ is true, it re-initializes.
  def native_instance(reload = false)
    @native_instance = if reload
      load_instance
    else
      @native_instance || load_instance
    end
  end

  # Returns the records.
  # If +reload+ is true, it re-initializes and re-runs the query.
  def records(reload = false)
    @records = if reload
      load_records
    else
      @records || load_records
    end
  end

  # Returns the value of the named +attribute+ from a recordset +row+.
  # Purpose is to encapsulate differences in addressing attribute values.
  def attribute_value(row,attribute)
    row.send(attribute)
  end
  
  # Loads the native dataset.
  #
  # Override this in specific dataset classes as required.
  def load_instance
    nil
  end
  protected :load_instance

  # Loads the native record set.
  #
  # Override this in specific dataset classes as required.
  def load_records
    nil
  end
  protected :load_records

  
end