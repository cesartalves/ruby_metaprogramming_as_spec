describe String do
  context "gsub" do
    it "substitutes all of first argument with the second" do
        expect("hello".gsub("ll", "l")).to eq "helo"
    end
  end
  
  context "split" do
    it "creates an array sepating at the given character" do
        expect("16/09/2019".split("/")).to eq ["16", "09", "2019"]
    end
  end
end