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

    xit "are a Proc/Closures" do
        expect { "any block really" }.to 
    end
end