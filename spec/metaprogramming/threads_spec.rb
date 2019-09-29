describe Thread do

    it "is the ruby implementation of concurrent programming" do

            # stolen from the docs: https://ruby-doc.org/core-2.5.0/Thread.html
            count = 0

            a = Thread.new { loop { count += 1 } }

            sleep 0.001       
            Thread.kill a 

            expect(count).to satisfy { count > 0 }
            expect(a.status).to eq false
            expect(a.alive?).to eq false
    end

    it "join" do

        pool = []
        count = 0

        5.times do 
            pool << Thread.new { count += 1 }
        end

        pool.each &:join

        expect(count).to eq 5

    end

    it "main" do

        expect(Thread.main.status).to eq "run"

    end
end