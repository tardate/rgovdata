# This is the catalog class that describes a generic file-based service
class RGovData::FileService < RGovData::Service

  # Returns an array of DataSets (keys) for the service
  # => overrides RGovData::Service.dataset_keys
  def dataset_keys
    [type]
  end

end