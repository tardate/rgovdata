# A ServiceListing is the metadata describing a specific service
# It encapsulates access to the underlying service
class Rgovdata::Service
  attr_reader :uri,:type,:transport

  class << self
    # Returns the appropriate Service class for the given uri and type
    # +realm+ is the required realm
    def get_instance(uri,type,transport)
      case type
      when :odata
        Rgovdata::OdataService.new(uri,type,transport)
      when :csv
        Rgovdata::CsvService.new(uri,type,transport)
      else # not a supported type
        nil
      end
    end
  end

  # +new+ requires
  # +uri+ url to the service interface
  # +type+ service type: :odata, :csv ..
  # +transport+ transport mechanism selector: :odata, :get
  def initialize(uri,type,transport)
    @uri,@type,@transport = uri,type,transport
  end

  # Returns an Array of attributes supported by the service
  # By default, it is nil - which means the attributes are indeterminate
  def attributes
  end

end