# frozen_string_literal: true

# Typed models for the IsEven SDK.
#
# GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
# params (op.<name>.points[].args.params[]). Member types come from the
# canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
# @voxgig/apidef VALID_CANON). Ruby types are unenforced; these YARD
# annotations document the shapes. Do not edit by hand.

# NumberParity entity data model.
#
# @!attribute [rw] ad
#   @return [String, nil]
#
# @!attribute [rw] iseven
#   @return [Boolean]
NumberParity = Struct.new(
  :ad,
  :iseven,
  keyword_init: true
)

# Request payload for NumberParity#load.
#
# @!attribute [rw] number
#   @return [Integer]
NumberParityLoadMatch = Struct.new(
  :number,
  keyword_init: true
)

