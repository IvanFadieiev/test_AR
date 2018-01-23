require_relative './rack_base'

# SwitchDb
class SwitchDb < RackBase
  class << self
    def unauth
      lambda { |env| [401, {}, [unauth_body]] }
    end

    private

    def unauth_body
      { body: 'Unauthorized', status: 401 }.to_json
    end
  end

  def call(env)
    if switch_condition?(env)
      switch_flow
    elsif current_db_condition?(env)
      current_db_flow
    else
      response('Not Found', 404)
    end
  rescue => e
    response(e, 500)
  end

  private

  def switch_condition?(env)
    request(env).post? && request(env).path.eql?('/system/switch')
  end

  def current_db_condition?(env)
    request(env).get? && request(env).path.eql?('/system/current_db')
  end

  def switch_flow
    DbSwitcher.write_file!
    response(current_db_name, 200)
  end

  def current_db_flow
    response(current_db_name, 200)
  end

  def current_db_name
    DbSwitcher.yaml_file['current_db']
  end
end
