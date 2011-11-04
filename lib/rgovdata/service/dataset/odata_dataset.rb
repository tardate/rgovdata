# This is the catalog class that describes an OData Service DataSet
class RGovData::OdataDataSet < RGovData::DataSet

  # Returns the native dataset key
  # => overrides RGovData::DataSet.native_dataset_key
  def native_dataset_key
    # TODO: is this generally true for OData??
    "#{dataset_key}Set"
  end

  # Returns the attribute names based on class meta-data
  # => overrides RGovData::Dn.attributes
  def attributes
    @attributes ||= native_service.class_metadata[dataset_key].keys
  end

  # Loads the native OData::QueryBuilder
  # => overrides RGovData::DataSet.load_instance
  def load_instance
    native_service.send(native_dataset_key)
  end
  protected :load_instance

  # Loads the native record set
  # => overrides RGovData::DataSet.load_records
  def load_records
    native_instance(true)
    native_instance.top(top) if top.present?
    service.native_instance.execute
  end
  protected :load_records
end