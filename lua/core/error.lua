-- IsEven SDK error

local IsEvenError = {}
IsEvenError.__index = IsEvenError


function IsEvenError.new(code, msg, ctx)
  local self = setmetatable({}, IsEvenError)
  self.is_sdk_error = true
  self.sdk = "IsEven"
  self.code = code or ""
  self.msg = msg or ""
  self.ctx = ctx
  self.result = nil
  self.spec = nil
  return self
end


function IsEvenError:error()
  return self.msg
end


function IsEvenError:__tostring()
  return self.msg
end


return IsEvenError
