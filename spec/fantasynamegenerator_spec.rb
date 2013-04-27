require 'fantasynamegenerator.rb'

# simple echo provider 
describe FantasyNameGenerator do
    
    before do
        # create object and load data from file
        @fng = FantasyNameGenerator.new        
        data = IO.read('test_template.yaml')        
        @fng.parse_yaml(data, {"Provider 1" => Provider.new, "Provider 2" => Provider.new})
    end

    it "Should render as expected" do
        @fng.render.should == "test-Child1 1 2 test-Child3-Child3Child2"
    end    
    
    it "Should render as expected" do        
        @fng.render(30).should == "test-Child1 1 2test-Child3-Child3Child2"
    end
    
    it "Should render as expected" do
        @fng.render(50).should == "test-Child1 1 2 test-Child3-Child3Child2"
    end
    
    it "Should render as expected" do
        @fng.render(55).should == " 1 2 test-Child3-Child3Child2"
    end

end
