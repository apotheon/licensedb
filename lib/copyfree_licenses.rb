require 'sequel'
require 'net/http'

class CopyfreeLicenses
  def license_names
    db.values.map {|license| license[:name] }
  end

  def db
    @db ||= { mit: { name: 'MIT License' } }
  end
end
