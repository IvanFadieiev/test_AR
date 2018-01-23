class DataParser
  attr_accessor :data

  def initialize(data)
    @data = data
  end

  def perform
    device_id = parsed_data['deviceId']
    parsed_data['data'].each do |sensors_batch_data|
      sensors_batch_data['s'].each do |sensor_data|
        SensorValue.create(device_id: device_id,
                           timestamp: DateTime.parse(sensors_batch_data['t']),
                           sensor_id: sensor_data['id'].to_s,
                           value: sensor_data['v'].to_s)
      end
    end
  end

  private

  def data # data MOCK
    File.read('./example.json')
  end

  def parsed_data
    JSON.parse(data)
  end
end
