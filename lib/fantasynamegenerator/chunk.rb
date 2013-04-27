# part of a name, this might be comprised of smaller chunks and or text
# to be randomly selected based on the position and name of this chunk
class Chunk
   
   # allow add_child to set paths when adding to parent chunks
   attr_accessor :name, :path, :children, :chance 
   
   # constructor
   def initialize(name, content=nil, provider=nil)
       @name = name
       @path = []
       @children = []
       @provider = provider
       @content = content
   end
   
   # add parent path and name when added as a child
   def add_path(path)
       @path = @path + path       
   end
   
   # made of up chunks instead of content, chance should be a range within
   # the range 0.100 and when render is used with a chance parameter only
   # children that match will be included.
   def add_child(chunk, chance=0..100)

        chunk.chance = chance
        chunk.add_path(@path + [@name])        
        chunk.children.each do | child |
            child.path = chunk.path + [chunk.name]
        end
        @children.push chunk
   end
   
   # get this chunks evaluated content from
   # either static content, provider or children
   def render(chance=nil)
       return @content if @content
       return @provider.content_for(@path, @name) if @provider

        @children.collect do | chunk |            
           chunk.render(chance) if !chance or !chunk.chance or chunk.chance.cover?(chance)
       end.join    
   end
   
   # factory for creating a simple space
   def self.space
       Chunk.new("space", " ")
   end
    
end