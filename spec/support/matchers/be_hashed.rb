require 'rspec/expectations'
require 'digest/sha1'

RSpec::Matchers.define :be_hashed do |expected|
  match do |actual|
    (Digest::SHA1.hexdigest expected) == actual
  end
end
