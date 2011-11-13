# This is the catalog class that describes an OData Service DataSet
class RGovData::OdataDataSet < RGovData::DataSet
  
  # Returns the attribute names based on class meta-data.
  #
  # Overrides RGovData::CatalogItem#attributes
  def attributes
    @attributes ||= native_service.class_metadata[entity_name].keys
  end

  # Returns the reated OData entity name for this DataSet.
  #
  # TODO: currently, this is a hack, as ruby_odata doesn't yet return the collection EntityType
  # (this is fixed in the current ruby_odata develop branch, so should be released soon)
  def entity_name
    dataset_key.gsub(/Set$/,'')
  end

  # Loads the native OData::QueryBuilder
  #
  # Overrides RGovData::DataSet#load_instance
  def load_instance
    native_service.send(key)
  end
  protected :load_instance

  # Loads the native record set
  #
  # Overrides RGovData::DataSet#load_records
  def load_records
    native_instance(true)
    native_instance.top(limit) if limit.present?
    Array(service.native_instance.execute)
  end
  protected :load_records
end