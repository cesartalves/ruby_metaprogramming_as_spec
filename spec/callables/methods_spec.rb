require 'spec_helper'

describe "Methods" do
  it "are also objets" do
     to_s = "Methods are objects".method :to_s
     expect(to_s.class.ancestors).to include Method 
  end

  it "methods can be unbonded from their original context" do
     to_s = subject.method :to_s
     expect(to_s.unbind.class.ancestors).to include UnboundMethod
  end
 
  it "using method on a to_proc" do
			
    class Getting
      def by_3(x)
        3 * x
      end
    end
        
    expect([1,2].map(&Getting.new.method(:by_3))).to eq [3, 6]

  end

  it "curry" do
    def foo(a,b,c)
      [a, b, c]
    end
    
    # directly from the Method doc

    proc  = self.method(:foo).curry
    proc2 = proc.call(1, 2) #=> #<Proc> 
      
    expect(proc2.call(3)).to eq [1,2,3]

  end
end
