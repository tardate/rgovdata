#!/usr/bin/env ruby
require 'rgovdata'

# This demonstrates how to use RGovData with OData web services
# Note: this example requires valid projectnimbus credentials in your rgovdata.conf file

RGovData::Catalog.get('//sg/nlb/LibrarySet').records.each { |library| puts library.Name }