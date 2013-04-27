require 'fantasynamegenerator.rb'

# simple echo provider 
describe Provider do
    
    before do
        @provider = Provider.new
    end

    it "Should echo content when array" do
        @provider.content_for(["1", "2"], "3").should == "1-2-3"
    end
    
    it "Should echo content when string" do
        @provider.content_for("12", "3").should == "12-3"
    end

    it "Should echo content when array of numbers" do
        @provider.content_for([1, 2], "3").should == "1-2-3"
    end

end
