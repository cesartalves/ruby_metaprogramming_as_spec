describe Kernel do

    it "has eval, this really dangerous method" do
        expect { eval "print 'a'"}.to output('a').to_stdout
    end

    it "is a module" do
        expect(subject.class).to eq Module
    end

    it "is included in all objects" do
        expect(Object.ancestors).to include subject
    end

    it "we can create a 'language keyword' by opening kernel" do

        module Kernel
            def my_keyword
                print "it's not a keyword! it's a method."
            end
        end

        expect { my_keyword }.to output("it's not a keyword! it's a method.").to_stdout

    end

end