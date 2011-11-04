require 'ruby_odata'

# This is the catalog class that describes an OData Service
class RGovData::OdataService < RGovData::Service

  # Returns an array of DataSets (keys) for the service
  def dataset_keys
    # @dataset_keys ||= native_instance.classes.keys
    @dataset_keys ||= native_instance.instance_variable_get(:@collections)
  end

  # Returns the native service object if applicable
  # By default, returns self
  def native_instance
    @native_instance ||= load_service
  end

  # Identifies, loads, and returns the native service instance
  def load_service
    clear
    # currently forcing SSL verification off (seems to be required for projectnimbus)
    # TODO: this should probably be a setting in the ServiceListing
    rest_options = {:verify_ssl=>false}
    if credentialset && credentialset != 'projectnimbus'
      credentials = config.credentialsets[credentialset]
      # merge basic auth
      rest_options.merge!({ :username => credentials['username'], :password => credentials['password'] })
    end
    svc = OData::Service.new(uri, rest_options)
    if credentialset && credentialset == 'projectnimbus'
      credentials = config.credentialsets[credentialset]
      # some special funk to insert headers for projectnimbus authentication
      actual_rest_options = svc.instance_variable_get(:@rest_options)
      rest_options = actual_rest_options.merge({:headers => {
        'AccountKey' => credentials['AccountKey'], 'UniqueUserID' => credentials['UniqueUserID']
      }})
      svc.instance_variable_set(:@rest_options,rest_options)
    end
    svc
  end
  protected :load_service

  # Clears current state
  # TODO: move to Dn?
  def clear
    @datasets = @dataset_keys = @native_instance = nil
  end
  protected :clear
end

