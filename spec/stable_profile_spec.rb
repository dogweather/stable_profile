# frozen_string_literal: true

RSpec.describe StableProfile do
  it "has a version number" do
    expect(StableProfile::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
