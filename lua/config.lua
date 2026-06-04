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
            ["name"] = "ad",
            ["req"] = false,
            ["type"] = "`$STRING`",
            ["active"] = true,
            ["index$"] = 0,
          },
          {
            ["name"] = "iseven",
            ["req"] = true,
            ["type"] = "`$BOOLEAN`",
            ["active"] = true,
            ["index$"] = 1,
          },
        },
        ["name"] = "number_parity",
        ["op"] = {
          ["load"] = {
            ["name"] = "load",
            ["points"] = {
              {
                ["args"] = {
                  ["params"] = {
                    {
                      ["example"] = 6,
                      ["kind"] = "param",
                      ["name"] = "number",
                      ["orig"] = "number",
                      ["reqd"] = true,
                      ["type"] = "`$INTEGER`",
                      ["active"] = true,
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
                ["active"] = true,
                ["index$"] = 0,
              },
            },
            ["input"] = "data",
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
