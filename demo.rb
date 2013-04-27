require_relative 'lib/fantasynamegenerator.rb'

provider = YamlProvider.new(IO.read('example_data.yaml'))

fng = FantasyNameGenerator.new        
data = IO.read('example_template.yaml')        
fng.parse_yaml(data, {"example" => provider})

(1..20).each do |n|
    puts fng.render(rand(1..100))
end