# frozen_string_literal: true

RSpec.describe StableProfile do
  it "has a version number" do
    expect(StableProfile::VERSION).not_to be nil
  end

  describe "StableProfile::OUTPUT_DIR" do
    subject { StableProfile::OUTPUT_DIR }
    it { is_expected.to be_a String }
  end
end
