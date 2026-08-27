# IsEven SDK configuration

module IsEvenConfig
  # Return the process-wide config, built once on first use. The SDK reads
  # the config on every request and never writes to it, so one instance is
  # shared by every client rather than rebuilt per client.
  #
  # The returned hash is shared: treat it as read-only. Callers that need to
  # mutate should use make_config, which always returns a fresh copy.
  def self.shared_config
    @shared_config ||= make_config
  end


  # Build a fresh, fully materialised config hash. Every call rebuilds the
  # whole structure, so prefer shared_config unless you need a private copy
  # you intend to mutate.
  def self.make_config
    {
      "main" => {
        "name" => "IsEven",
        "slug" => "is-even",
        "version" => "0.0.1",
        "target" => "rb",
      },
      "feature" => {
        "test" => {
          "options" => {
            "active" => false,
          },
          "transport" => "base",
        },
      },
      "options" => {
        "base" => "https://api.isevenapi.xyz/api",
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
              "short" => "Advertisement text (present in free tier, removed in Premium and Enterprise tiers)",
              "type" => "`$STRING`",
            },
            {
              "name" => "iseven",
              "req" => true,
              "short" => "True if the number is even, false if odd",
              "type" => "`$BOOLEAN`",
            },
          ],
          "name" => "number_parity",
          "op" => {
            "load" => {
              "input" => "data",
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
                      },
                    ],
                  },
                  "kind" => "http",
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
                },
              ],
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
