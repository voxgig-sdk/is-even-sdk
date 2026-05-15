# IsEven SDK exists test

require "minitest/autorun"
require_relative "../IsEven_sdk"

class ExistsTest < Minitest::Test
  def test_create_test_sdk
    testsdk = IsEvenSDK.test(nil, nil)
    assert !testsdk.nil?
  end
end
