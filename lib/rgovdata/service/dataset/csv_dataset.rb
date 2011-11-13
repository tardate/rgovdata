require 'csv'

# This is the catalog class that describes a CSV file service DataSet
class RGovData::CsvDataSet < RGovData::FileDataSet

  # Returns array of attributes that describe the records of the specific entity
  #
  # Overrides RGovData::CatalogItem.attributes
  def attributes
    records unless @attributes # forces a load
    @attributes
  end

  # Returns the value of the named +attribute+ from a recordset +row+
  #
  # Overrides RGovData::DataSet.attribute_value
  def attribute_value(row,attribute)
    row[attribute.to_s]
  end

  # Loads the native dataset (URI or File)
  #
  # Overrides RGovData::DataSet.load_instance
  def load_instance
    if uri =~ /^.+:\/\//
      URI.parse( uri )
    else
      File.new(uri, "r")
    end
  end
  protected :load_instance

  # Loads the native record set
  #
  # Overrides RGovData::DataSet.load_records
  def load_records
    csv = CSV.new(open(native_instance),{:headers=>:first_row}).read
    @attributes = csv.headers
    if limit.present?
      csv.entries[0,limit]
    else
      csv.entries
    end
  end
  protected :load_records

end