#!/usr/bin/env ruby
require 'rgovdata'

dataset = RGovData::Catalog.get('//us/eqs7day-M1/csv')
puts dataset.attributes.join(',')
dataset.records.each do |row|
  puts row
end