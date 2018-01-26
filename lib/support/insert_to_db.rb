# InsertToDB
class InsertToDB
  attr_accessor :data, :conn

  def initialize(data)
    @data = data
    @conn = ConnectionManagement.connect_to_db
  end

  def perform
    p_data = parsed_data
    statement_build(p_data)
    values_build(p_data)

    conn.prepare('statement1', @statement)
    conn.exec_prepared('statement1', @values_array)

    $logger.info @statement if ENV['LOG'].eql?('true')
    $logger.info @values_array.to_s if ENV['LOG'].eql?('true')

    conn.close if conn
  end

  private

  # def data # data MOCK
  #   File.read('./example.json')
  # end

  def parsed_data
    raise 'No data passed' if data.nil? || data.empty?
    JSON.parse(data).tap do |data|
      raise 'Data only in json' unless data.is_a?(Hash)
    end
  end

  def statement_build(parsed_data)
    array = []
    count = params_count(parsed_data)
    (1..count).step(4) do |i|
      array << "($#{i}, $#{i + 1}, $#{i + 2}, $#{i + 3})"
    end
    @statement = statement_query(array.join(', '))
  end

  def values_build(parsed_data)
    @values_array = []
    parsed_data['data'].each do |sensors_batch_data|
      sensors_batch_data['s'].each do |sensor_data|
        d = parsed_data['deviceId']
        t = timestamp(sensors_batch_data)
        s = sensor_id(sensor_data)
        v = value(sensor_data)
        @values_array << d << t << s << v
      end
    end
  end

  def params_count(parsed_data)
    4 * parsed_data['data'].map { |hash| hash['s'] }.flatten.size
  end

  def statement_query(values)
    "INSERT INTO sensor_values (device_id, timestamp, sensor_id, value) VALUES #{values}"
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
