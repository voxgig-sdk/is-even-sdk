# IsEven SDK configuration


_shared_config = None


def shared_config():
    """Return the process-wide config, built once on first use.

    The SDK reads the config on every request and never writes to it, so one
    instance is shared by every client rather than rebuilt per client.

    The returned dict is shared: treat it as read-only. Callers that need to
    mutate should use make_config, which always returns a fresh copy.
    """
    global _shared_config
    if _shared_config is None:
        _shared_config = make_config()
    return _shared_config


def make_config():
    """Build a fresh, fully materialised config dict.

    Every call rebuilds the whole structure, so prefer shared_config unless
    you need a private copy you intend to mutate.
    """
    return {
        "main": {
            "name": "IsEven",
            "slug": "is-even",
            "version": "0.0.1",
            "target": "py",
        },
        "feature": {
            "test": {
        "options": {
          "active": False,
        },
        "transport": "base",
      },
        },
        "options": {
            "base": "https://api.isevenapi.xyz/api",
            "headers": {
        "content-type": "application/json",
      },
            "entity": {
                "number_parity": {},
            },
        },
        "entity": {
      "number_parity": {
        "fields": [
          {
            "name": "ad",
            "short": "Advertisement text (present in free tier, removed in Premium and Enterprise tiers)",
            "type": "`$STRING`",
          },
          {
            "name": "iseven",
            "req": True,
            "short": "True if the number is even, false if odd",
            "type": "`$BOOLEAN`",
          },
        ],
        "name": "number_parity",
        "op": {
          "load": {
            "input": "data",
            "name": "load",
            "points": [
              {
                "args": {
                  "params": [
                    {
                      "example": 6,
                      "kind": "param",
                      "name": "number",
                      "orig": "number",
                      "reqd": True,
                      "type": "`$INTEGER`",
                    },
                  ],
                },
                "kind": "http",
                "method": "GET",
                "orig": "/iseven/{number}/",
                "parts": [
                  "iseven",
                  "{number}",
                ],
                "select": {
                  "exist": [
                    "number",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
              },
            ],
          },
        },
        "relations": {
          "ancestors": [
            [
              "iseven",
            ],
          ],
        },
      },
    },
    }
