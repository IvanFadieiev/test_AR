module CheckRequest
  # Request::Method
  class Method
    include RackHelper

    attr_accessor :app, :method

    def initialize(app, method)
      @app = app
      @method = method
    end

    def call(env)
      if request(env).request_method.eql?(method)
        @status, @headers, @body = app.call(env)
        [@status, @headers, @body]
      else
        response('Not Found', 404)
      end
    end
  end
end
