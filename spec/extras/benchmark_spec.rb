require 'benchmark'

describe Benchmark do

    it "measure" do
        Benchmark.measure { "a"*1_000_000}
    end

    it "bm" do

        Benchmark.bm(1) do |bench|
            bench.report("for:") { for i in 1..5000;  a = "1"; end }
        end
    end

end