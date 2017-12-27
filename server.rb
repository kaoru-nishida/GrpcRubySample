#!/usr/bin/env ruby

# Sample gRPC server that implements the Greeter::Helloworld service.
#
# Usage: $ path/to/greeter_server.rb

this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(this_dir, 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'grpc'
require 'Main_services_pb'

# GreeterServer is simple server that implements the Helloworld Greeter server.
class Server < Tell::DeviceConfirmation::Service
  def device_confirmation(req, _unused_call)
    p "-> 送られてきたデータ"
    p "deviceName : #{req.deviceName}"
    p "systemName : #{req.systemName}"
    p "systemVersion : #{req.systemVersion}"
    p "model : #{req.model}"
    p "applicationType : #{req.applicationType}"
    #p ""
    #p "#{_unused_call.peer}"
    Tell::Result.new(result: "OK")
  end
end

# main starts an RpcServer that receives requests to GreeterServer at the sample
# server port.
def main
  s = GRPC::RpcServer.new
  s.add_http2_port('0.0.0.0:50051', :this_port_is_insecure)
  s.handle(Server)
  s.run_till_terminated
end

main
