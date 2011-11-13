# This module defines the basic naming interface for catalog objects
# Override these methods as required
module RGovData::CatalogItem
  include Enumerable
  
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

  # Returns a rails-compatible ID
  def to_param
    id.gsub('/',':')
  end

  # Returns the human version of the object name/identification
  def to_s
    "#{id} [#{self.class.name}]"
  end

  # Returns array of attributes that describe the specific entity
  # By default, guesses based on instance variables
  def meta_attributes
    a = [:id]
    instance_variables.each do |v|
      n = v.to_s.gsub('@','').to_sym
      a << n if self.respond_to?(n)
    end
    a
  end

  # Returns a hash that fully describes this service and can be used as a parameter to +new+
  # By default, returns a hash based on meta_attributes
  def initialization_hash
    h = {}
    meta_attributes.each do |attribute|
      h.merge!(attribute => self.send(attribute))
    end
    h
  end

  # Returns array of attributes that describe the records of the specific entity
  # By default, it is nil (meaning indeterminate)
  def attributes
    @attributes
  end

  # Generic interface to return the currently applicable record set
  def records
    if defined? datasets
      datasets
    else
      []
    end
  end

  # Implements Enumerable#each
  def each
    records.each { |item| yield item }
  end
  
  # Returns indexed elements from the collection
  def [](*args)
    records[*args]
  end
  
  # Equality based on ID
  def ==(other)
    self.id == other.id
  end
  alias_method :eql?, :==


  # Returns the first record matching +key+
  def find_by_key(key)
    find { |r| r.key.to_s =~ /#{key}/}
  end

  # Returns all records matching +key+
  def find_all_by_key(key)
    select { |r| r.key.to_s =~ /#{key}/}
  end

end
