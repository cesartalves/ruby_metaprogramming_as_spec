describe Module do
    it "has new" do
        expect { subject.class.new }.not_to raise_error
    end

    it "has ancestors" do
        expect(subject.class.ancestors).to include(Module, Object, Kernel, BasicObject)
    end

    it "overriding append features" do

        module MyModule
            def self.append_features(base); end
        end

        Object.include(MyModule)
        expect(Object.ancestors).not_to include MyModule
    end

    it "nested modules" do

        module A
            module B
                module C
                end
            end
        end        
    end
end


module ModuleUnderstanding
    def a_method; 5; end
end

class UsingModules
    include ModuleUnderstanding
end

describe UsingModules do

    let(:new_class) { Class.new { extend ModuleUnderstanding } }

    it "ancestors will have module included" do
        expect(subject.class.ancestors).to include(ModuleUnderstanding)
    end

    it "its first ancestor is the last included" do
        expect(subject.class.ancestors[0]).to eq UsingModules
        expect(subject.class.ancestors[1]).to eq ModuleUnderstanding
    end

    it "extending modules adds the methods to the class, but not the instances" do 
        expect(new_class).to respond_to :a_method
        expect(new_class.new).not_to respond_to :a_method
        expect(new_class.ancestors).to include ModuleUnderstanding
    end

end