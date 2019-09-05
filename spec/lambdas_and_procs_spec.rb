describe "Lambdas" do

    let(:a_lambda) { -> { 5 }}

    it "They are instances of Proc" do
       expect(a_lambda.class).to eq Proc
    end

    it "they can be stored in variables, and called later on" do
        expect(a_lambda.call).to eq 5
    end

    it "Lambdas are Procs but Procs aren't lambdas" do
        expect(a_lambda.lambda?).to eq true
        expect(Proc.new { }.lambda?).to eq false   
    end

    it "Lambdas return from the inner scope" do
        _ = lambda { return 3 }
        _.call
    end

    it "Procs return from the outer scope" do
        _ = Proc.new { return 3 }
        skip("LocalJumpError expected here") do
            _.call
        end 
    end

    it "Procs and lambdas have arity" do
        a_proc = Proc.new { |x,y,z| x + y + z }
        a_lambda = lambda { |x,y,z|   x + y + z }
        expect(a_proc.arity).to eq 3
        expect(a_lambda.arity).to eq 3
    end

    it "Lambdas can't be run with wrong number of args" do
        expect { a_lambda.call(3,5) }.to raise_error ArgumentError
    end

    it "Procs can be run with wrong number of arguments" do
        a_proc = Proc.new { |x, y| x + y }
        expect { a_proc.call(1,2,3,4,5) }.not_to raise_error
    end
end