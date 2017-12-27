#!/usr/bin/env ruby

# Sample app that connects to a Greeter service.
#
# Usage: $ path/to/greeter_client.rb

this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(this_dir, 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'grpc'
require 'Main_services_pb'
require 'Main_pb'

def main
  stub = Tell::DeviceConfirmation::Stub.new('localhost:50051', :this_channel_is_insecure)
  result = stub.device_confirmation(Tell::DeviceInfo.new(deviceName:"Pixel C",systemName:"kaoru",systemVersion:"8.0.0",model:"NRD90M",applicationType:1)).result
  p "返り値 : #{result}"
end

main