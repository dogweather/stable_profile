# frozen_string_literal: true

RSpec.describe StableProfile do
  describe "StableProfile::OUTPUT_DIR" do
    subject { StableProfile::OUTPUT_DIR }
    it { is_expected.to be_a String }
  end
end
