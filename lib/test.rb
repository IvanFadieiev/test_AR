require 'open3'

start_time = Time.now

threads = []
1.upto(20) do
  threads << Thread.new do
    1.upto(50) do
      stdin, stdout, stderr, wait_thr = Open3.popen3(%w[curl -X POST http://192.168.2.141:3000/tracking -H 'cache-control: no-cache' -H 'content-type: application/json' -d '{"deviceId": "MY_DEVICE_ID", "data": [{"t": "2018-01-22T15:54:21.479Z", "s": [{"id": 1, "v": 0.2762986431054655}, {"id": 2, "v": 0.6470680805673417}, {"id": 3, "v": 0.930919699374408}, {"id": 123, "v": {"lat": 0.9961826432936711, "lon": 0.1762492468784287, "alt": 0.4435830413349826}}]}, {"t": "2018-01-22T15:54:21.584Z", "s": [{"id": 1, "v": 0.5556222929916794}, {"id": 2, "v": 0.9063087527986375}, {"id": 3, "v": 0.7172139449603494}, {"id": 123, "v": {"lat": 0.6090474370419083, "lon": 0.10963109615671862, "alt": 0.28563770351988627}}]}, {"t": "2018-01-22T15:54:21.685Z", "s": [{"id": 1, "v": 0.5964261807949829}, {"id": 2, "v": 0.06526091528260469}, {"id": 3, "v": 0.8267062775425253}, {"id": 123, "v": {"lat": 0.20461601312908306, "lon": 0.7105134956067536, "alt": 0.6884817287383533}}]}]}'].join(' '))
      stdout.gets(nil)
      stdout.close
      stderr.gets(nil)
      stderr.close
      exit_code = wait_thr.value
    end
  end
end

threads.each(&:join)

end_time = Time.now
result_time = end_time - start_time
puts Time.at(result_time).utc.strftime("%H:%M:%S:%L")
