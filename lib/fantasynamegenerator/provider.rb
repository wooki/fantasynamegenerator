# interface for providing content for chunks based on 
# the name and position of the chunk
class Provider
   
   # echo the content for testing
   def content_for(path, name)
       path = [path] if !path.kind_of?(Array)
       path.push(name).join('-')       
   end
    
end

