module CheckRequest
  # Request::ContentType
  class ContentType
    include RackHelper

    attr_accessor :app, :content_type

    def initialize(app, content_type)
      @app = app
      @content_type = content_type
    end

    def call(env)
      if request(env).content_type.eql?(content_type)
        @status, @headers, @body = app.call(env)
        [@status, @headers, @body]
      else
        response("Content-Type should be #{content_type}", 415)
      end
    end
  end
end
