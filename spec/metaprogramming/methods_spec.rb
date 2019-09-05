describe "Methods" do

    it "are also objets" do
        to_s = "Methods are objects".method :to_s
        expect(to_s.class.ancestors).to include Method 
    end

    it "methods can be unbonded from their original context" do
        to_s = subject.method :to_s
        expect(to_s.unbind.class.ancestors).to include UnboundMethod
    end

end