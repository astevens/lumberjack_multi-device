require 'lumberjack'

module Lumberjack
  # Write Lumberjack log entries to multiple devices.
  #
  # Calls to this device will be repeated to all devices assigned.
  class MultiDevice < Device
    attr_accessor :devices

    def initialize(devices = [])
      devices = [devices] unless devices.is_a?(Array)
      @devices = devices
    end

    def respond_to?(method, include_private = false)
      @devices.detect do |device|
        device.respond_to?(method, include_private)
      end || super
    end

    def method_missing(method, params, &block)
      @devices.each do |device|
        device.send(method, *params, &block)
      end
    end

  end # class MultiDevice
end # Module Lumberjack
