require 'spec_helper'
require 'support/mocks'
include MocksHelper

describe Rgovdata::YamlConfig do
  let(:filename) { 'config.yml' }
  let(:file_source) { mock_text(filename) }
  let(:yaml_config) { Rgovdata::YamlConfig.new(filename) }
  subject { yaml_config }
  before do
    File.stub(:read).and_return(file_source)
  end
  
  it "should allow access to settings as method calls" do
    subject.default_realm.should eql('sg')
  end
  it "should allow access to settings as array values" do
    subject['default_realm'].should eql('sg')
  end
end