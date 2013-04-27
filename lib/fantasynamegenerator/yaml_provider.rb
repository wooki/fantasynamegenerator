# interface for providing content for chunks based on 
# the name and position of the chunk from a yaml file
class YamlProvider
   
   # requires yaml data - see example_data.yaml file
   def initialize(yamldata)
       
       # parse the yaml - expecting a hash
       @hashdata = YAML::load(yamldata)
       raise ArgumentError, 'Invalid YAML format' if !@hashdata.kind_of? Hash       
   end
   
   
   # recurse into content looking for a match
   def content_for(path, name)       
       look_for_content(path + [name], @hashdata)       
   end

    # look for each element in the path in turn
    # and if found recurse to next level
    def look_for_content(path, data)

        # check for match
        if data[path.first]

            # return if we only have one left (i.e just matched)
            if path.length == 1
                return data[path.first][:values].sample
            end
                           
            # otherwise drop 1st item and drill down
            drilled = data[path.first]
            p = path.slice(1, path.length-1)                    
            matches = look_for_content(p, drilled)
            return matches if matches
            
            # if we didn't find that then keep dropping
            # from path but not data
            while p.length > 0
                matches = look_for_content(p, data)
                return matches if matches
                p = p.slice(1, p.length-1)
            end
        end
                
        nil
    end

end

