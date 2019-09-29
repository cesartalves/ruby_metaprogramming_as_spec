threads = 0

at_exit { puts "Your thread limit is #{threads} threads"  }

10_000.times do |i|
  begin
    Thread.new { sleep }
    threads += 1
  rescue ThreadError
    Kernel.exit(true)
  end
end