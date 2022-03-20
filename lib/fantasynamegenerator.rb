require 'yaml'
require File.dirname(__FILE__) + '/fantasynamegenerator/provider.rb'
require File.dirname(__FILE__) + '/fantasynamegenerator/chunk.rb'
require File.dirname(__FILE__) + '/fantasynamegenerator/yaml_provider.rb'

class FantasyNameGenerator

    # factory method to load default data
    def self.BuiltIn(template='north_euro_place')

        data_file = File.expand_path(File.dirname(__FILE__) + '/../builtin_data.yaml')
        template_file = File.expand_path(File.dirname(__FILE__) + '/../'+template+'.yaml')

        fng = FantasyNameGenerator.new

        provider = YamlProvider.new(IO.read(data_file))
        data = IO.read(template_file)
        fng.parse_yaml(data, {"builtin" => provider})

        fng
    end

    # recursively add node and it's children
    def add_chunks(chunkhash, providers)
        
        chunk = Chunk.new(chunkhash[:name], chunkhash[:content], providers[chunkhash[:provider]])
        
        if chunkhash[:children]
            chunkhash[:children].each do | child |

                chance = 0..100
                chance = Range.new(child[:chance][:from], child[:chance][:to]) if child[:chance]
                
                chunk.add_child(self.add_chunks(child, providers), chance)
            end
        end
        
        chunk
    end
    
    # parse a yaml string that defines chunk heirarchy and
    # a hash of named providers that can be referenced
    def parse_yaml(data, providers=[])
        
        # load and parse the yaml file
        hashdata = YAML::load(data)
        raise ArgumentError, 'Invalid YAML format' if !hashdata.kind_of? Hash
        
        # iterate through data creating equiv chunk structure
        @chunkdata = self.add_chunks(hashdata, providers)            
    end
    
    # evaluate the chunks and display
    def render(chance=nil)
        @chunkdata.render chance
    end

    # generate n names with random chance
    def random(n)

        names = []
        (1..n).each do | x |
            names.push self.render(rand(1..100))
        end
        names
    end
    
end

