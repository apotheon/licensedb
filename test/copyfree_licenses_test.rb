require 'minitest/spec'
require 'minitest/must_not'
require 'minitest/autorun'
require 'minitest/rg'

require '../lib/copyfree_licenses.rb'

require './helpers.rb'

describe CopyfreeLicenses do
  abbrev = 'COIL'
  name = 'Copyfree Open Innovation License'
  text = fixture_file('coil.txt')

  license_data = {
    abbrev: abbrev,
    name: name,
    text: text
  }

  no_license_error = {
    abbrev: nil,
    name: nil,
    text: nil, 
    error: 'no such license'
  }

  CopyfreeLicenses.new.tap do |cl|
    it 'returns a list of copyfree license names' do
      cl.names.must_include 'MIT License'
      cl.names.must_not_include name
    end

    it 'returns a list of copyfree license abbreviations' do
      cl.abbrevs.must_include 'MIT'
      cl.abbrevs.must_not_include abbrev
    end

    it 'does not find a nonexistent license' do
      cl.get_by_abbrev(abbrev).must_equal no_license_error
      cl.get_by_name(name).must_equal no_license_error
      cl.get_by_text(text).must_equal no_license_error
    end
  end

  CopyfreeLicenses.new.tap do |cl|
    before do
      cl.add_license license_data
    end

    it 'adds a license to the database and returns license texts' do
      cl.texts.must_include text
    end

    it 'gets a license by abbreviation' do
      cl.get_by_abbrev(abbrev).must_equal license_data
    end

    it 'gets a license by name' do
      cl.get_by_name(name).must_equal license_data
    end

    it 'gets a license by text' do
      cl.get_by_text(text).must_equal license_data
    end
  end
end
