describe "BlankSlate" do

    class BlankSlate
        instance_methods.each do |method|
            undef_method method unless method.to_s =~ /^__|method_missing|respond_to?/
          end
    end

    it "is a class devoid of methods, so we can dynamically proxy methods without worrying about them hitting others up
    in the class three" do
       
        expect(BlankSlate.instance_methods).to eq [:respond_to?, :__id__, :__send__]
    end
end