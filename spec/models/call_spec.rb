require "rspec/autorun"
require "./spec/spec_helper"

describe Call do
  its(:type) { should be_nil }
  its(:address) { should be_nil }
end
