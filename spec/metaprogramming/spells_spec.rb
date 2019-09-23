describe "Spells" do

    context "Class macro" do
        it "documentation" do

            class Object
                def self.help(method, description)
                    define_singleton_method("#{method}_help") { description }
                end

                class << self
                    help def b
                        "everything"
                    end, "does everything"
                end
                
                help def a
                    "nothing"
                end, "does nothing"  
            end

            expect(Object.a_help).to eq "does nothing"
            expect(Object.singleton_class.b_help).to eq "does everything"
            
           
        end

        it "attr_accessors" do
            class Accessor
                class << self
                    def access(attribute_name)
                       define_method(attribute_name) do 
                            instance_variable_get("@#{attribute_name}")
                       end

                       define_method("#{attribute_name}=") do |value|
                            instance_variable_set("@#{attribute_name}", value)
                       end
                        
                    end
                end

                access :oh_my
            end

            Accessor.new.oh_my = 10
            expect(Accessor.new).to respond_to :oh_my 
        end

        class Test
            def one_method; 1; end

            alias_method :one, :one_method
            alias_method "o", "one"

            def one_method
                one + one
            end
    
        end

        it "alias" do
            expect(Test.new).to respond_to :one
            expect(Test.new).to respond_to :o
        
        end

        it "around_alias" do

            # these are the same, just for the sake of reference
            Test.send :private, :one
            Test.class_eval { private :one }

            expect(Test.new).not_to respond_to :one
            expect(Test.new.one_method).to eq 2
        end

        it "prepend wrapper" do

            module StringExtension

                def length
                    super > 3 ? "long" : "short"
                end
            end

            String.prepend(StringExtension)
            expect("My".length).to eq "short"
        end

        it "deprecate" do
            class A
                def self.deprecate(old_method, options = {})    

                    raise "No new method given" unless options[:upgrade_to]
                    options[:with_message]  ||=  "Warning: #{old_method} is deprecated! Use #{options[:upgrade_to]} instead"   
                    
                    define_method(old_method) do |*args, &block|
                        print options[:with_message]
                        send(options[:upgrade_to], *args, &block) # `self` is assumed when calling `send`
                    end
                end
                
            end

            class A
                deprecate :old_version, upgrade_to: :new_version

                def new_version; end
            end

            expect { A.new.old_version }
                .to output("Warning: old_version is deprecated! Use new_version instead")
                .to_stdout
        end
    end

    context "Roflmao" do

        it "Make a string equal a different one" do

            class String
                alias_method :backup, :==

                def ==(value)
                    true
                end

            end
            
            expect("Vitor").to eq "O cara do meu lado"

            class String

                def ==(value)
                    backup(value)
                end
            end
        end
    end
end