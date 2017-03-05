require 'minitest/spec'
require 'minitest/must_not'
require 'minitest/autorun'
require 'minitest/rg'

require '../lib/license_db.rb'

require './helpers.rb'

describe LicenseDB do
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

  LicenseDB.new.tap do |ldb|
    it 'returns a list of copyfree license names' do
      ldb.names.must_include 'MIT License'
      ldb.names.must_not_include name
    end

    it 'returns a list of copyfree license abbreviations' do
      ldb.abbrevs.must_include 'MIT'
      ldb.abbrevs.must_not_include abbrev
    end

    it 'does not find a nonexistent license' do
      ldb.get_by_abbrev(abbrev).must_equal no_license_error
      ldb.get_by_name(name).must_equal no_license_error
      ldb.get_by_text(text).must_equal no_license_error
    end
  end

  LicenseDB.new.tap do |ldb|
    before do
      ldb.add_license license_data
    end

    it 'adds a license to the database and returns license texts' do
      ldb.texts.must_include text
    end

    it 'gets a license by abbreviation' do
      ldb.get_by_abbrev(abbrev).must_equal license_data
    end

    it 'gets a license by name' do
      ldb.get_by_name(name).must_equal license_data
    end

    it 'gets a license by text' do
      ldb.get_by_text(text).must_equal license_data
    end
  end
end
