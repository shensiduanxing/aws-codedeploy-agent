# require the code
require 'instance_agent'

class InstanceAgentTestCase < Test::Unit::TestCase
  include ActiveSupport::Testing::Assertions

  def setup
    @dir = '/tmp'
    ProcessManager::Config.init
    InstanceAgent::Log.init(File.join(@dir, 'codedeploy-agent.log'))
    InstanceAgent::Config.init
    InstanceAgent::Config.config[:log_dir] = @dir
    InstanceAgent::Config.config[:pid_dir] = @dir
    InstanceAgent::Config.config[:instance_service_region] = 'a-region'
    InstanceAgent::Config.config[:instance_service_endpoint] = 'instance-service-endpoint'
    InstanceAgent::Config.config[:instance_service_port] = 123
    InstanceAgent::Config.config[:wait_after_error] = 0
    InstanceAgent::Platform.util = InstanceAgent::LinuxUtil
  end

  def assert_raised_with_message(message, error_type = RuntimeError)
    error = assert_raise(error_type) { yield }
    assert_equal(message, error.message)
  end
end
