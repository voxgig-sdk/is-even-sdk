package = "voxgig-sdk-is-even"
version = "0.0-1"
source = {
  url = "git://github.com/voxgig-sdk/is-even-sdk.git"
}
description = {
  summary = "IsEven SDK for Lua",
  license = "MIT"
}
dependencies = {
  "lua >= 5.3",
  "dkjson >= 2.5",
  "dkjson >= 2.5",
}
build = {
  type = "builtin",
  modules = {
    ["is-even_sdk"] = "is-even_sdk.lua",
    ["config"] = "config.lua",
    ["features"] = "features.lua",
  }
}
