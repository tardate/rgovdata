require 'spec_helper'

# This runs integration tests against the actual OData service
# It uses credentials from the yaml config file in the project root folder
describe "SG NLB Service" do
  let(:config) { RGovData::Config.instance }
  before :all do
    config.load_config(integration_test_config_filename, {:generate_default => true,:required => true})
  end
  after :all do
    config.clear
  end

  it "should description" do
    
  end
end