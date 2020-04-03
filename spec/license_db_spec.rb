require '../lib/license_db.rb'
require './helpers.rb'

RSpec.describe LicenseDB do
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

  describe 'with empty DB' do
    LicenseDB.new.tap do |ldb|
      describe '#names' do
        it 'returns a list of copyfree license names' do
          expect(ldb.names).to include 'MIT License'
          expect(ldb.names).to_not include name
        end
      end

      describe '#abbrevs' do
        it 'returns a list of copyfree license abbreviations' do
          expect(ldb.abbrevs).to include 'MIT'
          expect(ldb.abbrevs).to_not include abbrev
        end
      end

      describe '#get_by_abbrev' do
        it 'does not find a nonexistent license' do
          expect(ldb.get_by_abbrev abbrev).to eql no_license_error
          expect(ldb.get_by_name name).to eql no_license_error
          expect(ldb.get_by_text text).to eql no_license_error
        end
      end
    end
  end

  describe 'with DB including COIL' do
    LicenseDB.new.tap do |ldb|
      before do
        ldb.add_license license_data
      end

      describe '#texts' do
        it 'adds a license to the database and returns license texts' do
          expect(ldb.texts).to include text
        end
      end

      describe '#get_by_abbrev' do
        it 'gets a license by abbreviation' do
          expect(ldb.get_by_abbrev abbrev).to eql license_data
        end
      end

      describe '#get_by_name' do
        it 'gets a license by name' do
          expect(ldb.get_by_name name).to eql license_data
        end
      end

      describe '#get_by_text' do
        it 'gets a license by text' do
          expect(ldb.get_by_text text).to eql license_data
        end
      end
    end
  end
end
