threads = []

threads << Thread.new do
  1.upto(20000) do
    system('curl -X POST http://localhost:3000/data')
  end
end

threads << Thread.new do
  1.upto(20000) do
    system('curl -X POST http://localhost:3000/data')
  end
end

threads.each(&:join)
