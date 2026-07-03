-- ProjectName SDK configuration

local function make_config()
  return {
    main = {
      name = "IsEven",
    },
    feature = {
      ["test"] = {
        ["options"] = {
          ["active"] = false,
        },
      },
    },
    options = {
      base = "https://api.isevenapi.xyz/api",
      auth = {
        prefix = "Bearer",
      },
      headers = {
        ["content-type"] = "application/json",
      },
      entity = {
        ["number_parity"] = {},
      },
    },
    entity = {
      ["number_parity"] = {
        ["fields"] = {
          {
            ["active"] = true,
            ["name"] = "ad",
            ["req"] = false,
            ["type"] = "`$STRING`",
            ["index$"] = 0,
          },
          {
            ["active"] = true,
            ["name"] = "iseven",
            ["req"] = true,
            ["type"] = "`$BOOLEAN`",
            ["index$"] = 1,
          },
        },
        ["name"] = "number_parity",
        ["op"] = {
          ["load"] = {
            ["input"] = "data",
            ["name"] = "load",
            ["points"] = {
              {
                ["active"] = true,
                ["args"] = {
                  ["params"] = {
                    {
                      ["active"] = true,
                      ["example"] = 6,
                      ["kind"] = "param",
                      ["name"] = "number",
                      ["orig"] = "number",
                      ["reqd"] = true,
                      ["type"] = "`$INTEGER`",
                    },
                  },
                },
                ["method"] = "GET",
                ["orig"] = "/iseven/{number}/",
                ["parts"] = {
                  "iseven",
                  "{number}",
                },
                ["select"] = {
                  ["exist"] = {
                    "number",
                  },
                },
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body`",
                },
                ["index$"] = 0,
              },
            },
            ["key$"] = "load",
          },
        },
        ["relations"] = {
          ["ancestors"] = {
            {
              "iseven",
            },
          },
        },
      },
    },
  }
end


local function make_feature(name)
  local features = require("features")
  local factory = features[name]
  if factory ~= nil then
    return factory()
  end
  return features.base()
end


-- Attach make_feature to the SDK class
local function setup_sdk(SDK)
  SDK._make_feature = make_feature
end


return make_config
