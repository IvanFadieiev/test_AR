# SensorValue
class SensorValue < ActiveRecord::Base
  # jsonb_accessor :data,
  #                sensor_id: :integer,
  #                value: :string

  def value
    if value_attr.include?('{')
      JSON.parse(value_attr.gsub('=>', ':'))
    else
      value_attr
    end
  end

  def value_attr
    read_attribute('value')
  end
end
