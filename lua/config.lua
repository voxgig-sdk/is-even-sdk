-- IsEven SDK configuration

-- Build a fresh, fully materialised config table. Every call rebuilds the
-- whole structure, so prefer require("config_shared") unless you need a
-- private copy you intend to mutate.
local function make_config()
  return {
    main = {
      name = "IsEven",
      slug = "is-even",
      version = "0.0.1",
      target = "lua",
    },
    feature = {
      ["test"] = {
        ["options"] = {
          ["active"] = false,
        },
        ["transport"] = "base",
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
            ["short"] = "Advertisement text (present in free tier, removed in Premium and Enterprise tiers)",
            ["type"] = "`$STRING`",
          },
          {
            ["name"] = "iseven",
            ["req"] = true,
            ["short"] = "True if the number is even, false if odd",
            ["type"] = "`$BOOLEAN`",
          },
        },
        ["name"] = "number_parity",
        ["op"] = {
          ["load"] = {
            ["input"] = "data",
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
                    },
                  },
                },
                ["kind"] = "http",
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
              },
            },
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
