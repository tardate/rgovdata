#!/usr/bin/env ruby
require 'rgovdata'

# This demonstrates the essential process of traversing the RGovData catalog
# Note: this example probably requires valid projectnimbus credentials in your rgovdata.conf file
# since it will blindly traverse the tree and may hit a projectnimbus service

# This gets the root catalog
root_catalog = RGovData::Catalog.new(nil)

puts "The root catalog has a collection of realms: #{root_catalog.records}"
# => root_catalog.realms is an alias for root_catalog.records at this level

# Take the first realm catalog
catalog = root_catalog.records.first

puts "The first catalog is: #{catalog}"
puts "And it contains the following service listings: #{catalog.records}"
# => catalog.services is an alias for catalog.records at this level

# Take the first service listing
service_listing = catalog.records.first

puts "The first service_listing is: #{service_listing}"
puts "=> it represents the underlying service: #{service_listing.service}"

puts "=> it has the following datasets: #{service_listing.records}"
# => service_listing.datasets is an alias for service_listing.records at this level

# Take the first dataset
dataset = service_listing.records.first

puts "The first dataset is: #{dataset}"
puts "=> it has the following attributes: #{dataset.attributes}"
puts "=> it has the following number records: #{dataset.records.count}"

