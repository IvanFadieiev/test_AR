class RackBase
  private

  def request(env)
    Rack::Request.new(env)
  end

  def response(body, status)
    Rack::Response.new({ body: body, status: status }.to_json, status)
  end
end
