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

        it "shift" do
            expect([1,2,3].shift).to eq 1
        end

        it "pop" do
            expect([1,2,3].pop).to eq 3
        end

        it "drop" do
            expect([1,2,3].drop 1).to eq [2,3]
        end

        it "compact" do
            expect([1,2, nil,3, nil].compact).to eq [1,2,3]
        end

        it "take_while" do
            max = 3
            expect([1,2,3,4].take_while { |n| n <= max}).to eq [1,2,3]
        end
    end
end