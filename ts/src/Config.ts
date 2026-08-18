
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


  main = {
    name: 'IsEven',
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
          "type": "`$STRING`"
        },
        {
          "name": "iseven",
          "req": true,
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

