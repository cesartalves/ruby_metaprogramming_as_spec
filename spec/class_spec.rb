
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

    it "can have ghost instance method" do
      expect { subject.ghost }.to raise_error(NoMethodError)

      def subject.ghost; true; end

      expect(subject.ghost).to eq true
    end

    it "can have ghost class method" do
      expect { Class.ghost }.to raise_error(NoMethodError)

      def Class.ghost; true; end

      expect { Class.ghost }.not_to raise_error

    end
end