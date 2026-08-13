package core

func MakeConfig() map[string]any {
	return map[string]any{
		"main": map[string]any{
			"name": "IsEven",
		},
		"feature": map[string]any{
			"test": map[string]any{
				"options": map[string]any{
					"active": false,
				},
			},
		},
		"options": map[string]any{
			"base": "https://api.isevenapi.xyz/api",
			"headers": map[string]any{
				"content-type": "application/json",
			},
			"entity": map[string]any{
				"number_parity": map[string]any{},
			},
		},
		"entity": map[string]any{
			"number_parity": map[string]any{
				"fields": []any{
					map[string]any{
						"active": true,
						"name": "ad",
						"req": false,
						"type": "`$STRING`",
						"index$": 0,
					},
					map[string]any{
						"active": true,
						"name": "iseven",
						"req": true,
						"type": "`$BOOLEAN`",
						"index$": 1,
					},
				},
				"name": "number_parity",
				"op": map[string]any{
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"active": true,
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"active": true,
											"example": 6,
											"kind": "param",
											"name": "number",
											"orig": "number",
											"reqd": true,
											"type": "`$INTEGER`",
											"index$": 0,
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/iseven/{number}/",
								"parts": []any{
									"iseven",
									"{number}",
								},
								"select": map[string]any{
									"exist": []any{
										"number",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"index$": 0,
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{
						[]any{
							"iseven",
						},
					},
				},
			},
		},
	}
}

func makeFeature(name string) Feature {
	switch name {
	case "test":
		if NewTestFeatureFunc != nil {
			return NewTestFeatureFunc()
		}
	default:
		if NewBaseFeatureFunc != nil {
			return NewBaseFeatureFunc()
		}
	}
	return nil
}
