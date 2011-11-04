require 'uri'
require 'open-uri'

# This is the catalog class that describes a generic file service DataSet
# Currently only handles text files
class RGovData::FileDataSet < RGovData::DataSet

  # Returns array of attributes that describe the records of the specific entity
  # Generic FileDataSets don't have attributes, returns a single selector for the row
  # => overrides RGovData::Dn.attributes
  def attributes
    ['row']
  end

  # Returns the value of the named +attribute+ from a recordset +row+
  # Generic FileDataSets don't have attributes, so always return full row
  # => overrides RGovData::DataSet.attribute_value
  def attribute_value(row,attribute)
    row
  end

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