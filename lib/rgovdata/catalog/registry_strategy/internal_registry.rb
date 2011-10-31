class Rgovdata::InternalRegistry < Rgovdata::RegistryStrategy
  
  # Returns the list of services for the realm
  # based on internal yml file
  def load_services
    service_array = []
    registry = Rgovdata::Template.get('registry.yml',realm)
    YAML::load_documents( registry ) { |doc| service_array << doc }
    service_array
  end

end