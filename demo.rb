require_relative 'lib/fantasynamegenerator.rb'

puts "="*10
puts "CUSTOM FILES x6"
puts "="*10

data_file = File.expand_path(File.dirname(__FILE__) + '/builtin_data.yaml')
template_file = File.expand_path(File.dirname(__FILE__) + '/dothraki_male_template.yaml')

fng = FantasyNameGenerator.new

provider = YamlProvider.new(IO.read(data_file))
data = IO.read(template_file)
fng.parse_yaml(data, {"dothraki-male" => provider})

fng.random(6).each do |  name |
	puts name
end

puts "="*10
fng = FantasyNameGenerator.BuiltIn 'norse_template'
puts "Norse Name: #{fng.random(1).first}"
puts "="*10
fng = FantasyNameGenerator.BuiltIn 'carpathian_male_template'
puts "Carpathian Male Name: #{fng.random(1).first}"
puts "="*10
fng = FantasyNameGenerator.BuiltIn 'north_euro_place'
puts "North European Place: #{fng.random(1).first}"
puts "="*10
fng = FantasyNameGenerator.BuiltIn 'spanish_place'
puts "Spanish Place: #{fng.random(1).first}"
puts "="*10
