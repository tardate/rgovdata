require 'ruby_odata'
class RGovData::ODataService < RGovData::Service

  # Returns an Array of attributes supported by the service
  # By default, it is nil - which means the attributes are indeterminate
  def attributes
  end

  # Returns an array of DataSets (names) for the service
  def datasets
  end

  # Returns the native service object if applicable
  # By default, returns self
  def native_instance
    @native_instance ||= load_service
  end

  def load_service
    # currently forcing SSL verification off (seems to be required for projectnimbus)
    # TODO: this should probably be a setting in the ServiceListing
    rest_options = {:verify_ssl=>false}
    if credentialset == 'basic'
      # merge basic auth
      rest_options.merge!({ :username => "bob", :password=> "12345" })
    end
    svc = OData::Service.new(uri, rest_options)
    if credentialset == 'projectnimbus'
      # some special funky to insert headers for projectnimbus authentication
      actual_rest_options = svc.instance_variable_get(:@rest_options)
      rest_options = actual_rest_options.merge({:headers=>{'AccountKey'=>'blah', 'UniqueUserID'=>'00000000000000000000000000000001'}})
      svc.instance_variable_set(:@rest_options,rest_options)
    end
    svc
  end
  protected :load_service

end

