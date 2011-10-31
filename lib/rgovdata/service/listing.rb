# A ServiceListing is the metadata describing a specific service
# It encapsulates access to the underlying service
class RGovData::ServiceListing
  attr_accessor :realm         # realm for the service
  attr_accessor :key           # unique service name or id (within realm)
  attr_accessor :name          # human name of the service
  attr_accessor :description   # human description of the service
  attr_accessor :keywords      # keywords for the service
  attr_accessor :publisher     # service publisher name
  attr_accessor :license       # license covering the service if any
  attr_accessor :info_uri      # url to a web page about the service if any
  attr_accessor :uri           # url to the service interface
  attr_accessor :type          # service type [:odata,:csv]
  attr_accessor :transport     # transport mechanism [:odata,:get]
  attr_accessor :credentialset # name of the credential set required

  def as_param
    "//#{realm}/#{key}"
  end

  def service
    @service ||= RGovData::Service.get_instance(uri,type,transport,credentialset)
  end

end