require 'ruby_odata'
class RGovData::OdataService < RGovData::Service

  # # Returns an array of DataSets (names) for the service
  # def datasets
  # end

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
      credentials = config.credentialsets['basic']
      # merge basic auth
      rest_options.merge!({ :username => credentials['username'], :password => credentials['password'] })
    end
    svc = OData::Service.new(uri, rest_options)
    if credentialset == 'projectnimbus'
      credentials = config.credentialsets['projectnimbus']
      # some special funky to insert headers for projectnimbus authentication
      actual_rest_options = svc.instance_variable_get(:@rest_options)
      rest_options = actual_rest_options.merge({:headers => {
        'AccountKey' => credentials['AccountKey'], 'UniqueUserID' => credentials['UniqueUserID']
      }})
      svc.instance_variable_set(:@rest_options,rest_options)
    end
    svc
  end
  protected :load_service

end

