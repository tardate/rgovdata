require 'uri'
require 'open-uri'

# This is the catalog class that describes a generic file service DataSet
# Currently only handles text files
class RGovData::FileDataSet < RGovData::DataSet

  # Loads the native dataset (URI or File)
  # => overrides RGovData::DataSet.load_instance
  def load_instance
    if uri =~ /^.+:\/\//
      URI.parse( uri )
    else
      File.new(uri, "r")
    end
  end
  protected :load_instance

  # Loads the native record set
  # => overrides RGovData::DataSet.load_records
  def load_records
    # open(native_instance,"UserAgent" => "Mozilla/5.0")
    strio = StringIO.new(open(native_instance).read)
    if limit.present?
      strio.to_a[0,limit]
    else
      strio
    end
  end
  protected :load_records

end