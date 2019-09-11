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

    xit "included" do
    end
    xit "extend" do
    end
end