
import { BaseFeature } from './feature/base/BaseFeature'
import { TestFeature } from './feature/test/TestFeature'



const FEATURE_CLASS: Record<string, typeof BaseFeature> = {
   test: TestFeature,

}


class Config {

  makeFeature(this: any, fn: string) {
    const fc = FEATURE_CLASS[fn]
    const fi = new fc()
    // TODO: errors etc
    return fi
  }

  // False for a feature added at runtime via options.extend (station's
  // adopt path) - the constructor uses this to skip makeFeature for names
  // no generated class backs.
  hasFeature(this: any, fn: string) {
    return null != FEATURE_CLASS[fn]
  }


  main = {
    name: 'IsEven',
        slug: "is-even",
    version: "0.0.1",
    target: "ts",

  }


  feature = {
     test:     {
      "options": {
        "active": false
      }
    },

  }


  options = {
    base: "https://api.isevenapi.xyz/api",

    headers: {
      "content-type": "application/json"
    },

    entity: {
      
      number_parity: {
      },

    }
  }


  entity = {
    "number_parity": {
      "fields": [
        {
          "name": "ad",
          "short": "Advertisement text (present in free tier, removed in Premium and Enterprise tiers)",
          "type": "`$STRING`"
        },
        {
          "name": "iseven",
          "req": true,
          "short": "True if the number is even, false if odd",
          "type": "`$BOOLEAN`"
        }
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
                    "reqd": true,
                    "type": "`$INTEGER`"
                  }
                ]
              },
              "kind": "http",
              "method": "GET",
              "orig": "/iseven/{number}/",
              "parts": [
                "iseven",
                "{number}"
              ],
              "select": {
                "exist": [
                  "number"
                ]
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": [
          [
            "iseven"
          ]
        ]
      }
    }
  }
}


const config = new Config()

export {
  config
}

