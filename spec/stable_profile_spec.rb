# frozen_string_literal: true

RSpec.describe StableProfile do
  it "has a version number" do
    expect(StableProfile::VERSION).not_to be nil
  end
end
