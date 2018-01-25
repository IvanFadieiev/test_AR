require_relative './rack_base'

# DataEndpoint
class DataEndpoint < RackBase
  def call(env)
    unless request(env).content_type.eql?('application/json')
      return response("Content-Type should be 'application/json'", 415)
    end

    if request(env).post? && request(env).path.eql?('/tracking')
      data = request(env).body.read
      if data.empty?
        return response('Data should be passed', 406)
      end
      InsertToDB.new(data).perform
      response('Ok', 201)
    else
      response('Not Found', 404)
    end
  rescue => e
    response(e, 500)
  end
end
