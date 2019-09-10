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
    end

end