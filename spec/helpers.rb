def spec_dir
  File.dirname File.expand_path __FILE__
end

def fixture_file filename
  File.read File.join spec_dir, 'fixtures', filename
end
