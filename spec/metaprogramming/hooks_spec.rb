describe "Hooks" do
    it "inherited" do
        klass = Class.new do
            class << self
                def inherited(subclass)
                    print "inherited"
                end
            end

        end

        expect { Class.new(klass) }.to output("inherited").to_stdout

    end

    it "included" do
        module MyModule
            def self.included(includee) 
                includee.define_method(:get_hooked) { |one, two| one + two } 
            end
        end

        klass = Class.new

        klass.include(MyModule)

        expect(klass.ancestors.[](1)).to eq MyModule
        expect(klass.new).to respond_to :get_hooked
    end
   
    it "prepended" do
        module MyModule
            def self.prepended(includee) 
                includee.define_method(:get_hooked) { |one, two| one + two } 
            end
        end

        klass = Class.new

        klass.prepend(MyModule)

        expect(klass.ancestors.[](0)).to eq MyModule
        expect(klass.new).to respond_to :get_hooked

    end

    it "extended" do
        module MyModule
            def first; end

            def self.extended(extendee)
                
                extendee.class_eval do
                    class << self
                        self.define_method(:static) { 1 }
                    end
                end
                super

                # or define_singleton_method / singleton_class.define_method
            end
        end

        klass = Class.new

        klass.extend(MyModule)

        expect(klass.ancestors).to include MyModule
        expect(klass).to respond_to :first
        expect(klass).to respond_to :static

    end

    it "extend on included (pseudo-concern)" do
        module MyModule
            def one_instance_method; end;

            def self.extended(extendee)
                extendee.include(MyModule)
            end
        end

        klass = Class.new
        klass.extend(MyModule)

        
        expect(klass.new).to respond_to :one_instance_method

    end


    it "coerce" do
        class String
            def coerce(other); [other, self.to_i]; end
        end
          
        expect(1 + "1").to eq 2

        class String
            def coerce(other); [other.to_s, self] end
        end

        expect(1 + "2").to eq "12"

        class String
            def coerce(other); [self, other.to_s] end
        end

        expect(1 + "2").to eq "21"
       
    end
end