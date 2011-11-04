#!/usr/bin/env ruby
require 'rgovdata'

quakes = RGovData::Catalog.get('//us/eqs7day-M1/csv').records.count
puts "Holy Harp Array Batman, there have been #{quakes} M1+ quakes this week!"
