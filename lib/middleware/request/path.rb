module CheckRequest
  # Request::Path
  class Path
    include RackHelper

    attr_accessor :app, :path

    def initialize(app, path)
      @app = app
      @path = path
    end

    def call(env)
      if request(env).path.eql?(path)
        @status, @headers, @body = app.call(env)
        [@status, @headers, @body]
      else
        response('Not Found', 404)
      end
    end
  end
end
