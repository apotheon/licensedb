require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/rg'

require '../lib/copyfree_licenses.rb'

describe CopyfreeLicenses do
  CopyfreeLicenses.new.tap do |cl|
    it 'returns a list of copyfree license names' do
      cl.license_names.must_include 'MIT License'
    end
  end
end
