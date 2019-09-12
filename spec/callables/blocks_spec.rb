describe "Ruby Blocks" do

    def method_using_block_implicitly
        yield
    end

    def method_using_block_explicity(&block)
        block.call
    end

    it "they will run the code which is passed to the method" do
        expect(method_using_block_implicitly { 5 }).to eq 5
    end

    it "they can be multilined, like a foreach" do
        expect(
            method_using_block_implicitly do
                4   
            end).to eq 4
    end

    it "they can receive block explicitly" do
        expect(method_using_block_explicity {5} ).to eq 5
    end

    it "they can raise erros if no blocks are passed" do
        expect { method_using_block_implicitly }.to raise_error LocalJumpError
    end

    it "are a Proc/Closures" do
        
    end

    it "Self yield" do
        class Object
            def yield_self
                yield self.class
            end
        end

        expect do 
            "This is a string".yield_self { |x| print x }
        end.to output('String').to_stdout
    end

    it "Symbol.to_proc" do
        expect([1, 2, 3].map(&:to_s)).to include("1", "2", "3")

        # this is how ruby implements it, sort of

        class Symbol
            def to_proc
                Proc.new { |x| x.send self }

            end
        end

        expect([1, 2, 3].map(&:to_s)).to include("1", "2", "3")
    end
end