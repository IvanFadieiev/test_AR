require_relative './rack_base'

# DataEndpoint
class DataEndpoint < RackBase
  def call(env)
    data = request(env).body.read
    InsertToDB.new(data).perform
    response('Ok', 201)
  rescue => e
    response(e, 500)
  end
end
