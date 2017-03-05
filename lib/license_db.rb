class LicenseDB
  def abbrevs
    db.map {|license| license[:abbrev] }
  end

  def names
    db.map {|license| license[:name] }
  end

  def texts
    db.map {|license| license[:text] }
  end

  def add_license license_data
    db << license_data
  end

  def get_by_abbrev abbreviation
    begin
      db[abbrevs.find_index abbreviation]
    rescue TypeError => e
      { abbrev: nil, name: nil, text: nil, error: 'no such license' }
    end
  end

  def get_by_name name
    begin
      db[names.find_index name]
    rescue TypeError => e
      { abbrev: nil, name: nil, text: nil, error: 'no such license' }
    end
  end

  def get_by_text text
    begin
      db[texts.find_index text]
    rescue TypeError => e
      { abbrev: nil, name: nil, text: nil, error: 'no such license' }
    end
  end

  private

  def db
    @db ||= [
      {
        abbrev: 'MIT',
        name: 'MIT License'
      }
    ]
  end
end
