# IsEven SDK utility: feature_add
module IsEvenUtilities
  FeatureAdd = ->(ctx, f) {
    ctx.client.features << f
  }
end
