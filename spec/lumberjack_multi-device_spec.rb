require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Lumberjack::MultiDevice do
  context "setup to proxy to two log devices" do
    let(:first_device) {double('log device', :valid_method => "valid_result")}
    let(:second_device) {double('log device', :valid_method => "valid_result")}
    let(:multi_device) {Lumberjack::MultiDevice.new([first_device, second_device])}

    it "proxies calls to more than one device" do
      first_device.should_receive("valid_method").with("valid_param")
      second_device.should_receive("valid_method").with("valid_param")

      multi_device.valid_method("valid_param")
    end
  end
end
