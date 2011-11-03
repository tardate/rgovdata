# This is the catalog class that describes a generic file-based service
class RGovData::FileService < RGovData::Service

  # Returns an array of DataSets (names) for the service
  def datasets
    @datasets ||= load_data_sets
  end

  # Initialises the dataset collection
  def load_data_sets
    dataset_class = "RGovData::#{type.to_s.capitalize}DataSet".constantize
    Array(dataset_class.new)
  rescue
    []
  end
  protected :load_data_sets
end