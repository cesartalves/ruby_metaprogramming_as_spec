describe "Singleton Classes" do

    context "Singleton Classes" do
        it "Can be revealed through the class keyword" do
            obj = Object.new

            singleton_class = class << obj
                                self
                              end
                            
            expect(obj.singleton_class).to eq singleton_class
        end

        it "The superclass of the singleton class is the class" do
            obj = Object.new

            expect(obj.singleton_class.superclass).to eq Object
        end

        it "The superclass of the singleton class is the singleton class of the superclass" do
            expect(Object.singleton_class.superclass).to eq Object.superclass.singleton_class
        end

    end

    context "Singleton Methods" do
        it "syntax 1" do
            class Object
                def self.static_method

                end
            end

            expect(Object.singleton_methods).to include(:static_method)

        end

        it "syntax 2" do
            class Object
                class << self
                    def static_method
                        "#O"
                    end
                end
            end

            expect(Object.singleton_methods)
        end
        
    end

end