require 'sequel'
require 'net/http'

class CopyfreeLicenses
  attr_accessor :db

  def initialize
    @db = {
      mit: {
        name: 'MIT License'
      }
    }
  end

  def license_names
    db.values.map {|license| license[:name] }
  end
end
