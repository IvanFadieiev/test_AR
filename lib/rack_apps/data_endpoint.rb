require_relative './rack_base'

# DataEndpoint
class DataEndpoint < RackBase
  def call(env)
    if request(env).post? && request(env).path.eql?('/data')
      data = request(env).params['sensor_data']
      InsertToDB.new(data).perform
      response('Ok', 201)
    else
      response('Not Found', 404)
    end
  rescue => e
    response(e, 500)
  end
end
