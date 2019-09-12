describe Array do
    context "operators" do
        it "reduce" do
            expect([1,1,2].reduce { |x,y| x + y}).to eq 4 
        end

        it "map" do
            expect([1,1,1].map { |x| x * 2 }).to eq [2,2,2]
        end

        it "filter" do
            expect([1,2,3].reject { |x| x % 2 == 0}).to eq [1,3]
        end
    end
end