# The InternalRegistry strategy works with file-based registries
# of services built-in to the gem ( in lib/rgovdata/data)
#
# This only meant to be a stop-gap and final fallback mechanism,
# and used to bootstrap rgovdata in the absence of external directory
# services.
#
class RGovData::InternalRegistry < RGovData::RegistryStrategy

  # Returns the list of services for the realm
  # based on internal yml file
  def load_services
    service_array = []
    registry = RGovData::Template.get('registry.yml',realm)
    YAML::load_documents( registry ) { |doc| service_array << doc }
    service_array
  end

end