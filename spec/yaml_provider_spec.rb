require 'fantasynamegenerator.rb'

# yaml based provider
# due to nature of code this doesn't work with more than one
# value for a given node so doesn't test sample call. meh.
describe YamlProvider do
    
    before do
        data = IO.read('test_data.yaml')   
        @provider = YamlProvider.new(data)
    end

    it "Should get from just name at top level" do
        @provider.content_for([], 'test').should == "aaaa"
    end
    
    it "Should get from one level deep" do
        @provider.content_for(['test'], 'Child1').should == "gggg"
    end
    
    it "Should get from two levels deep" do
        @provider.content_for(['test', 'Child3'], 'Child3Child2').should == "oooo"
    end
    
    it "Should get from just name at different level" do
        @provider.content_for([], 'set 2').should == "zzzz"
    end
    
    it "Should match lower level path regardless of top level" do
        @provider.content_for(['test'], 'set 2').should == "zzzz"
    end
    
    it "Should match lower level path regardless of top level" do
        @provider.content_for(['set 2', 'test'], 'Child3').should == "rrrr"
    end
end
