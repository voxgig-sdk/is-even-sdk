package voxgigisevensdk

import (
	"github.com/voxgig-sdk/is-even-sdk/core"
	"github.com/voxgig-sdk/is-even-sdk/entity"
	"github.com/voxgig-sdk/is-even-sdk/feature"
	_ "github.com/voxgig-sdk/is-even-sdk/utility"
)

// Type aliases preserve external API.
type IsEvenSDK = core.IsEvenSDK
type Context = core.Context
type Utility = core.Utility
type Feature = core.Feature
type Entity = core.Entity
type IsEvenEntity = core.IsEvenEntity
type FetcherFunc = core.FetcherFunc
type Spec = core.Spec
type Result = core.Result
type Response = core.Response
type Operation = core.Operation
type Control = core.Control
type IsEvenError = core.IsEvenError

// BaseFeature from feature package.
type BaseFeature = feature.BaseFeature

func init() {
	core.NewBaseFeatureFunc = func() core.Feature {
		return feature.NewBaseFeature()
	}
	core.NewTestFeatureFunc = func() core.Feature {
		return feature.NewTestFeature()
	}
	core.NewNumberParityEntityFunc = func(client *core.IsEvenSDK, entopts map[string]any) core.IsEvenEntity {
		return entity.NewNumberParityEntity(client, entopts)
	}
}

// Constructor re-exports.
var NewIsEvenSDK = core.NewIsEvenSDK
var TestSDK = core.TestSDK
var NewContext = core.NewContext
var NewSpec = core.NewSpec
var NewResult = core.NewResult
var NewResponse = core.NewResponse
var NewOperation = core.NewOperation
var MakeConfig = core.MakeConfig
var NewBaseFeature = feature.NewBaseFeature
var NewTestFeature = feature.NewTestFeature
