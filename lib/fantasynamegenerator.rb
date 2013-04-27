require 'yaml'
require_relative 'fantasynamegenerator/provider.rb'
require_relative 'fantasynamegenerator/chunk.rb'
require_relative 'fantasynamegenerator/yaml_provider.rb'

class FantasyNameGenerator
    
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
    
end

