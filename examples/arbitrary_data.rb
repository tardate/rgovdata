#!/usr/bin/env ruby
require 'rgovdata'

# This demonstrates how to use RGovData with arbitrary services
# currently not supported by RGovData::Catalog

# The minimum requirement is a +uri+ and +type+
# You may need to add a +credentialset+ if authentication is required
options = {
  :uri => "http://earthquake.usgs.gov/earthquakes/catalogs/eqs7day-M1.txt",
  :type => :csv
}

# Directly create the service endpoint
service = RGovData::Service.get_instance(options)

puts "Manufactured a service: #{service}"
puts "With uri: #{service.uri}"
puts "And type: #{service.type}"

# Now we can use the service to access the dataset (only one in this case since it is a CSV file service)
dataset = service.datasets.first

# And work with the data:
puts "This dataset has the following attributes: #{dataset.attributes.join(',')}"
puts "And it has #{dataset.records.count} rows of data"
