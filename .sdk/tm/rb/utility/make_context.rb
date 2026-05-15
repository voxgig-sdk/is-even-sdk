# IsEven SDK utility: make_context
require_relative '../core/context'
module IsEvenUtilities
  MakeContext = ->(ctxmap, basectx) {
    IsEvenContext.new(ctxmap, basectx)
  }
end
