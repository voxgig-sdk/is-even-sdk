
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
    name: 'ProjectName',
  }


  feature = {
     test:     {
      "options": {
        "active": false
      }
    },

  }


  options = {
    base: 'https://api.isevenapi.xyz/api',

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
          "active": true,
          "name": "ad",
          "req": false,
          "type": "`$STRING`",
          "index$": 0
        },
        {
          "active": true,
          "name": "iseven",
          "req": true,
          "type": "`$BOOLEAN`",
          "index$": 1
        }
      ],
      "name": "number_parity",
      "op": {
        "load": {
          "input": "data",
          "name": "load",
          "points": [
            {
              "active": true,
              "args": {
                "params": [
                  {
                    "active": true,
                    "example": 6,
                    "kind": "param",
                    "name": "number",
                    "orig": "number",
                    "reqd": true,
                    "type": "`$INTEGER`",
                    "index$": 0
                  }
                ]
              },
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
              },
              "index$": 0
            }
          ],
          "key$": "load"
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

