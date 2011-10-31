def get_temp_file(basename)
  require 'tempfile'
  f = Tempfile.new(basename)
  path = f.path
  f.close!()
  path
end

def supported_realms
  [:sg,:us]
end

# Returns the config for integration testing
def integration_test_config_filename
  filename = "#{File.dirname(__FILE__)}/../../#{RGovData::Config::BASE_NAME}"
  STDERR.puts "Running integration tests with config: #{filename}"
  filename
end