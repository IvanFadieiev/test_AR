# DataEndpoint
class DataEndpoint
  def call(env)
    [200, {}, [SensorValue.all.inspect]]
  end
end
