# IsEven SDK configuration

module IsEvenConfig
  def self.make_config
    {
      "main" => {
        "name" => "IsEven",
      },
      "feature" => {
        "test" => {
          "options" => {
            "active" => false,
          },
        },
      },
      "options" => {
        "base" => "https://api.isevenapi.xyz/api",
        "auth" => {
          "prefix" => "Bearer",
        },
        "headers" => {
          "content-type" => "application/json",
        },
        "entity" => {
          "number_parity" => {},
        },
      },
      "entity" => {
        "number_parity" => {
          "fields" => [
            {
              "name" => "ad",
              "req" => false,
              "type" => "`$STRING`",
              "active" => true,
              "index$" => 0,
            },
            {
              "name" => "iseven",
              "req" => true,
              "type" => "`$BOOLEAN`",
              "active" => true,
              "index$" => 1,
            },
          ],
          "name" => "number_parity",
          "op" => {
            "load" => {
              "name" => "load",
              "points" => [
                {
                  "args" => {
                    "params" => [
                      {
                        "example" => 6,
                        "kind" => "param",
                        "name" => "number",
                        "orig" => "number",
                        "reqd" => true,
                        "type" => "`$INTEGER`",
                        "active" => true,
                      },
                    ],
                  },
                  "method" => "GET",
                  "orig" => "/iseven/{number}/",
                  "parts" => [
                    "iseven",
                    "{number}",
                  ],
                  "select" => {
                    "exist" => [
                      "number",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "active" => true,
                  "index$" => 0,
                },
              ],
              "input" => "data",
              "key$" => "load",
            },
          },
          "relations" => {
            "ancestors" => [
              [
                "iseven",
              ],
            ],
          },
        },
      },
    }
  end


  def self.make_feature(name)
    require_relative 'features'
    IsEvenFeatures.make_feature(name)
  end
end
