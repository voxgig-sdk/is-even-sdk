# IsEven SDK utility registration
require_relative '../core/utility_type'
require_relative 'clean'
require_relative 'done'
require_relative 'make_error'
require_relative 'feature_add'
require_relative 'feature_hook'
require_relative 'feature_init'
require_relative 'fetcher'
require_relative 'make_fetch_def'
require_relative 'make_context'
require_relative 'make_options'
require_relative 'make_request'
require_relative 'make_response'
require_relative 'make_result'
require_relative 'make_point'
require_relative 'make_spec'
require_relative 'make_url'
require_relative 'param'
require_relative 'prepare_auth'
require_relative 'prepare_body'
require_relative 'prepare_headers'
require_relative 'prepare_method'
require_relative 'prepare_params'
require_relative 'prepare_path'
require_relative 'prepare_query'
require_relative 'graphql'
require_relative 'result_basic'
require_relative 'result_body'
require_relative 'result_headers'
require_relative 'transform_request'
require_relative 'transform_response'

IsEvenUtility.registrar = ->(u) {
  u.clean = IsEvenUtilities::Clean
  u.done = IsEvenUtilities::Done
  u.make_error = IsEvenUtilities::MakeError
  u.feature_add = IsEvenUtilities::FeatureAdd
  u.feature_hook = IsEvenUtilities::FeatureHook
  u.feature_init = IsEvenUtilities::FeatureInit
  u.fetcher = IsEvenUtilities::Fetcher
  u.make_fetch_def = IsEvenUtilities::MakeFetchDef
  u.make_context = IsEvenUtilities::MakeContext
  u.make_options = IsEvenUtilities::MakeOptions
  u.make_request = IsEvenUtilities::MakeRequest
  u.make_response = IsEvenUtilities::MakeResponse
  u.make_result = IsEvenUtilities::MakeResult
  u.make_point = IsEvenUtilities::MakePoint
  u.make_spec = IsEvenUtilities::MakeSpec
  u.make_url = IsEvenUtilities::MakeUrl
  u.param = IsEvenUtilities::Param
  u.prepare_auth = IsEvenUtilities::PrepareAuth
  u.prepare_body = IsEvenUtilities::PrepareBody
  u.prepare_headers = IsEvenUtilities::PrepareHeaders
  u.prepare_method = IsEvenUtilities::PrepareMethod
  u.prepare_params = IsEvenUtilities::PrepareParams
  u.prepare_path = IsEvenUtilities::PreparePath
  u.prepare_query = IsEvenUtilities::PrepareQuery
  u.graphql_body = IsEvenUtilities::GraphqlBody
  u.graphql_errors = IsEvenUtilities::GraphqlErrors
  u.result_basic = IsEvenUtilities::ResultBasic
  u.result_body = IsEvenUtilities::ResultBody
  u.result_headers = IsEvenUtilities::ResultHeaders
  u.transform_request = IsEvenUtilities::TransformRequest
  u.transform_response = IsEvenUtilities::TransformResponse
}
