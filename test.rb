require 'open3'
start_time = Time.now

threads = []
threads << Thread.new do
  1.upto(1000) do
    stdin, stdout, stderr, wait_thr = Open3.popen3('curl -X POST http://localhost:3000/data')
    stdout.gets(nil)
    stdout.close
    stderr.gets(nil)
    stderr.close
    exit_code = wait_thr.value
  end
end

threads << Thread.new do
  1.upto(1000) do
    stdin, stdout, stderr, wait_thr = Open3.popen3('curl -X POST http://localhost:3000/data')
    stdout.gets(nil)
    stdout.close
    stderr.gets(nil)
    stderr.close
    exit_code = wait_thr.value
  end
end

threads << Thread.new do
  1.upto(1000) do
    stdin, stdout, stderr, wait_thr = Open3.popen3('curl -X POST http://localhost:3000/data')
    stdout.gets(nil)
    stdout.close
    stderr.gets(nil)
    stderr.close
    exit_code = wait_thr.value
  end
end

threads << Thread.new do
  1.upto(1000) do
    stdin, stdout, stderr, wait_thr = Open3.popen3('curl -X POST http://localhost:3000/data')
    stdout.gets(nil)
    stdout.close
    stderr.gets(nil)
    stderr.close
    exit_code = wait_thr.value
  end
end

threads.each(&:join)

end_time = Time.now
result_time = end_time - start_time
puts Time.at(result_time).utc.strftime("%H:%M:%S:%L")
