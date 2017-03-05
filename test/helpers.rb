def fixture_file filename
  File.read File.join(
    File.dirname(File.expand_path __FILE__), 'fixtures', filename
  )
end
