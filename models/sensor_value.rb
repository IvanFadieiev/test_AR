# # SensorValue
# class SensorValue < Sequel::Model
#   def value
#     if value_attr.include?('{')
#       JSON.parse(value_attr.gsub('=>', ':'))
#     else
#       value_attr
#     end
#   end
#
#   def value_attr
#     read_attribute('value')
#   end
# end
