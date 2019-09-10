
describe Class do

    it "has no constants" do
      expect(subject.constants).to be_empty 
    end

    it "is an instance of class" do
      expect(subject.class).to be Class
    end

    it "is a child of Object" do
       expect(subject.superclass).to be Object
    end

    it "is class is a child of Module" do
      expect(subject.class.superclass).to be Module
    end

    it "has methods" do
      expect(subject.instance_methods).to include(:instance_variable_set)
    end

    it "can have ghost instance / singleton instance method" do
      expect { subject.ghost }.to raise_error(NoMethodError)

      def subject.ghost; true; end

      expect(subject.ghost).to eq true
      expect(subject.singleton_methods).not_to be_empty
      expect(subject).to respond_to :define_singleton_method

    end

    it "can have ghost class method" do
      expect { Class.ghost }.to raise_error(NoMethodError)

      def Class.ghost; true; end

      expect { Class.ghost }.not_to raise_error

    end

    context "advanced class concepts" do
      
      it "class_eval() evaluates a block (Flat scope)" do
        expect(subject.class_eval { self.ancestors }).to include Module

        def add_method_to(klass)
          klass.class_eval do 
            def my_age; 25; end;
          end
        end

        add_method_to(Object)

        expect(Object.new).to respond_to :my_age
        expect(Object.new.my_age).to eq 25

      end

      it "class_eval() comes from Module" do
        Module.module_eval { }
      end

      it "they can contain instance variables (because they're instances of Class)" do
        class Class
          @v1 = 10
        end
        expect(Class.instance_variable_get("@v1")).to eq 10
       
      end

      it "there are also classes variables, but they're dangerous" do
        class Class
          @@v1 = 10
        end
        expect(Class.class_variable_get("@@v1")).to eq 10

      end

      it "magic set methods, cause why not?" do
        class Obj; end;

        require 'securerandom'

        Obj.instance_variable_set "@#{"any_variable"}", 1
        Obj.class_variable_set "@@#{"any_variable"}", 1

        expect(Obj.instance_variables).not_to be_empty
        expect(Obj.class_variables).not_to be_empty
      end

      it "Creating a class without the class keyword" do
        MyClass = Class.new(Array) do 
          def my_method; "Hello"; end
        end

        MyClass.new.my_method
      end
    end
end