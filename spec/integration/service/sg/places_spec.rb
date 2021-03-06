require 'spec_helper'

# This runs integration tests against the actual OData service
# It uses credentials from the rgovdata.conf file in the project root folder
# describe "Places.sg Service" do
#   let(:config) { RGovData::Config.instance }
#   before :all do
#     config.load_config(integration_test_config_filename, {:generate_default => true,:required => true})
#   end
#   after :all do
#     config.clear
#   end
#
#   describe "ServiceListing" do
#     let(:id) { '//sg/places' }
#     let(:dataset_key) { 'Places' }
#     let(:example_attribute) { 'company_name' }
#     let(:record_class) { Places }
#
#     let(:service_listing) { RGovData::Catalog.get(id) }
#
#     subject { service_listing }
#     it { should be_a(RGovData::ServiceListing) }
#
#     describe "#service" do
#       let(:service) { service_listing.service }
#       subject { service }
#       it { should be_a(RGovData::Service) }
#       describe "#dataset_keys" do
#         subject { service.dataset_keys }
#         it { should include(dataset_key) }
#         context "map to collections" do
#           let(:collections) { service.native_instance.instance_variable_get(:@collections) }
#           it "should include all" do
#             collections.each do |collection|
#               subject.should include(collection)
#             end
#           end
#         end
#       end
#       # describe "#classes" do
#       #   subject { service.native_instance.classes }
#       #   it { puts subject.inspect }
#       # end
#       # describe "#class_metadata" do
#       #   subject { service.native_instance.class_metadata }
#       #   it { puts subject.inspect }
#       # end
#     end
#
#     describe "#find_by_key" do
#       let(:dataset) { service_listing.find_by_key(dataset_key) }
#       subject { dataset }
#       it { should be_a(RGovData::OdataDataSet) }
#       describe "#attributes" do
#         subject { dataset.attributes }
#         it { should include(example_attribute) }
#       end
#       describe "#records" do
#         let(:record_limit) { 3 }
#         before {
#           dataset.limit = record_limit
#         }
#         subject { dataset.records }
#         it { should be_a(Array) }
#         its(:first) { should be_a(record_class) }
#         its(:count) { should eql(record_limit) }
#       end
#
#     end
#   end
#
# end