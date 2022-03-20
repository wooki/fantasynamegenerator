Gem::Specification.new do |s|
  s.name        = 'fantasynamegenerator'
  s.version     = '0.0.3'
  s.date        = '2013-04-24'
  s.summary     = "Generate fantasy character names"
  s.description = "Randomly generate fantasy character names from templates"
  s.authors     = ["Jim Rowe"]
  s.email       = 'jim@jimcode.org'
  s.files       = ["lib/fantasynamegenerator.rb",
                   "lib/fantasynamegenerator/chunk.rb",
                   "lib/fantasynamegenerator/provider.rb",
                   "lib/fantasynamegenerator/yaml_provider.rb",
                   "example_data.yaml",
                   "carpathian_male_template.yaml",
                   "north_euro_place.yaml",
                   "spanish_place.yaml"
                   ]
  s.homepage    = 'http://www.jimcode.org/fantasynamegenerator'
  s.executables << 'fngen'
end
