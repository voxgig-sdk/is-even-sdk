# IsEven SDK configuration


def make_config():
    return {
        "main": {
            "name": "IsEven",
        },
        "feature": {
            "test": {
        "options": {
          "active": False,
        },
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
            "active": True,
            "name": "ad",
            "req": False,
            "type": "`$STRING`",
            "index$": 0,
          },
          {
            "active": True,
            "name": "iseven",
            "req": True,
            "type": "`$BOOLEAN`",
            "index$": 1,
          },
        ],
        "name": "number_parity",
        "op": {
          "load": {
            "input": "data",
            "name": "load",
            "points": [
              {
                "active": True,
                "args": {
                  "params": [
                    {
                      "active": True,
                      "example": 6,
                      "kind": "param",
                      "name": "number",
                      "orig": "number",
                      "reqd": True,
                      "type": "`$INTEGER`",
                      "index$": 0,
                    },
                  ],
                },
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
                "index$": 0,
              },
            ],
            "key$": "load",
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
