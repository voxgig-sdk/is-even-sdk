package core

var UtilityRegistrar func(u *Utility)

var NewBaseFeatureFunc func() Feature

var NewTestFeatureFunc func() Feature

var NewNumberParityEntityFunc func(client *IsEvenSDK, entopts map[string]any) IsEvenEntity

