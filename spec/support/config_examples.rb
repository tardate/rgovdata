shared_examples_for "includes common config" do
  # Expects on entry:
  # +subject+ is set to the instance to test
  describe "#config" do
    it { should respond_to(:config) }
    its(:config) { should be_a(RGovData::Config) }
  end
end