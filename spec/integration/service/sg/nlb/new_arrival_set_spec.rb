require 'spec_helper'

# This runs integration tests against the actual OData service
# It uses credentials from the rgovdata.conf file in the project root folder
describe "SG NLB Service - NewArrivalSet" do
  let(:config) { RGovData::Config.instance }
  before :all do
    config.load_config(integration_test_config_filename, {:generate_default => true,:required => true})
  end
  after :all do
    config.clear
  end

  let(:dataset) { RGovData::Catalog.get('//sg/nlb/NewArrivalSet') }

  describe "#dataset" do
    subject { dataset }
    it { should be_a(RGovData::OdataDataSet) }

    describe "dataset#records" do
      subject { dataset.records }
      it "should return an Array of NewArrival records" do
        pending "GH#3 the ProjectNimbus NLB NewArrivalSet doesn't seem to be live yet, or there's something more we need to know to use it"
        subject.should be_a(Array)
        subject.first.should be_a(NewArrival)
      end
    end

  end


end