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
    nameparts.push(key) if defined?(key)
    nameparts.join('/')
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
