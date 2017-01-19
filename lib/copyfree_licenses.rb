require 'sequel'

class CopyfreeLicenses
  def license_names
    db.values.map {|license| license[:name] }
  end

  private

  def db
    @db ||= { mit: { name: 'MIT License' } }
  end
end
