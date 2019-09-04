describe "Metaprogramming" do

    class ObjectWithMethod
        def multiply_by_two(number); number*2; end
    end

    it "Dynamically dispatching methods" do
        expect(ObjectWithMethod.new.send(:multiply_by_two, 3)).to eq 6
    end

    it "We can call method_missing on BasicObject" do
        expect { BasicObject.new.send(:method_missing, 'method')}.to raise_error NoMethodError
    end

    it "We can define methods dynamically with define method" do
        ObjectWithMethod.define_method(:multiply_by_three) { |arg| arg * 3}

        expect(ObjectWithMethod.new).to respond_to :multiply_by_three
    end

    it "We can define methods dynamically by overriding method_missing" do
        class ObjectWithMethod
            def method_missing(method, *args)
                if match = method.match(/multiply_by_(\d*)/)
                    match.captures.first.to_i * args.first
                else
                    super
                end
            end

            def respond_to_missing?(method, *args)
                method.match(/multiply_by_(\d*)/) && args.length == 1
            end
        end
        
        expect(ObjectWithMethod.new).to respond_to :multiply_by_1500
        expect(ObjectWithMethod.new.send(:multiply_by_2000, 10)).to eq 20000
    end
end