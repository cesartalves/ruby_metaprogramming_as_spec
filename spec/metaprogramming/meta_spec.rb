describe "Metaprogramming" do

    class ObjectWithMethod

        def initialize()
            @variable = 1
        end

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

    context "magic methods" do
        it "instance_eval for peeking attributes" do
            expect(ObjectWithMethod.new.instance_eval { @variable }).to eq 1
        end

        it "instance_eval for defining methods on the fly on a class" do
            ObjectWithMethod.class.instance_eval do
                def add_to_3(number)
                     3 + number
                end 
            end
            expect(ObjectWithMethod.class.add_to_3(3)).to eq 6 

        end

        it "instance_eval for defining ghost method on instance" do
            obj = ObjectWithMethod.new

            obj.instance_eval do
                def add_to_3(number)
                     3 + number
                end 
            end

            expect(obj.add_to_3(3)).to eq 6 
        end

        it "create a global method with a flat scope, from a variable" do
            
            @variable = "talk_about"

            Kernel.send :define_method, @variable do |subject, &block|
                print "#{subject}: #{block.call}"
            end 

            expect { 
                talk_about "Metaprogramming" do 
                    "it's cool"
                end
            }.to output("Metaprogramming: it's cool").to_stdout          
        end

        it "public send (like eval)" do
            expect(public_send("class")).to eq RSpec::ExampleGroups::Metaprogramming::MagicMethods
        end
    end

    it "constant missing can also be overriden!" do
        class Class # or Module, but on module we don't have access to super
            def const_missing(name)
                if (name.to_s == "Constant")
                    Class.new    
                else
                    super
                end
            end
        end

        Constant
        expect { Const }.to raise_error NameError
    end
end