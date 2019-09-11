describe "Spells" do

    context "Class macro" do
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
    end
end