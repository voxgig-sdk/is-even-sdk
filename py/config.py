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
            "name": "ad",
            "req": False,
            "type": "`$STRING`",
            "active": True,
            "index$": 0,
          },
          {
            "name": "iseven",
            "req": True,
            "type": "`$BOOLEAN`",
            "active": True,
            "index$": 1,
          },
        ],
        "name": "number_parity",
        "op": {
          "load": {
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
                      "active": True,
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
                "active": True,
                "index$": 0,
              },
            ],
            "input": "data",
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
