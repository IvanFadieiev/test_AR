# DataParser
class DataParser
  attr_accessor :data, :conn

  def initialize(data)
    @data = data
    @conn = ConnectionManagement.connect_to_db
  end

  def perform
    device_id = parsed_data['deviceId']
    conn.prepare('statement1',
                 'insert into sensor_values (device_id, timestamp, sensor_id, value) values ($1, $2, $3, $4)')
    parsed_data['data'].each do |sensors_batch_data|
      sensors_batch_data['s'].each do |sensor_data|
        h = { d: device_id,
              t: timestamp(sensors_batch_data),
              s: sensor_id(sensor_data),
              v: value(sensor_data) }
        conn.exec_prepared('statement1', [h[:d], h[:t], h[:s], h[:v]])
      end
    end
  ensure
    conn.close if conn
  end

  private

  def data # data MOCK
    File.read('./example.json')
  end

  def parsed_data
    JSON.parse(data)
  end

  def timestamp(data)
    Time.parse(data['t']).strftime('%Y-%m-%d %H:%M:%S.%4N')
  end

  def sensor_id(data)
    data['id'].to_s
  end

  def value(data)
    data['v'].to_s
  end
end

# select * from sensor_values WHERE timestamp BETWEEN '2018-01-22 15:54:21.684'::timestamp and now()::timestamp;
