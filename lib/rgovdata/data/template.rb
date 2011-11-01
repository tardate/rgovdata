require 'pathname'

# This is a convenience class for accessing disk-based template files
# It avoids pathname processing from being required where template are used
class RGovData::Template
  
  class << self
    # Returns the template file path
    # +name+ is the filename
    # +realm+ if specified is the subdirectory
    def path(name, realm = nil)
      extra_path = [realm,name].compact.map(&:to_s)
      Pathname.new(File.dirname(__FILE__)).join(*extra_path).to_s
    rescue
      nil
    end

    # Returns the template file content
    # +name+ is the filename
    # +realm+ if specified is the subdirectory
    def get(name, realm = nil)
      IO.read(path(name, realm))
    rescue
      nil
    end
  end
end