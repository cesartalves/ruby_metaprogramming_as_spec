describe Kernel do

    it "has eval, this really dangerous method" do
        expect { eval "print 'a'"}.to output('a').to_stdout
    end

end