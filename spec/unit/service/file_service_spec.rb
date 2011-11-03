require 'spec_helper'

describe RGovData::FileService do

  let(:credentialset) { 'basic' }
  let(:service) { RGovData::CsvService.new('uri','csv','get',credentialset) }

  before {
    # These tests won't call on a real service
  }

  describe "#native_instance" do
  end

  describe "#datasets" do
    
  end

end