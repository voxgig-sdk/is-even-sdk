-- IsEven SDK exists test

local sdk = require("is-even_sdk")

describe("IsEvenSDK", function()
  it("should create test SDK", function()
    local testsdk = sdk.test(nil, nil)
    assert.is_not_nil(testsdk)
  end)
end)
