# This module defines the basic naming interface for catalog objects
# Override these methods as required
module RGovData::Dn
  
  # Returns the human-readable unique id
  def id
    nameparts = []
    if defined? realm
      nameparts.push('/')
      nameparts.push(realm)
    end
    nameparts.push(service_key) if defined?(service_key) && service_key.present?
    nameparts.push(dataset_key) if defined?(dataset_key) && dataset_key.present?
    nameparts.join('/')
  end
  def to_param
    id.gsub('/',':')
  end

  # Returns the human version of the object
  def to_s
    "#{id} [#{self.class.name}]"
  end

  # Generic interface to return the currently applicable record set
  def records
    if defined? datasets
      datasets
    else
      []
    end
  end

end
