# NumberParity entity test

require "minitest/autorun"
require "json"
require_relative "../IsEven_sdk"
require_relative "runner"

class NumberParityEntityTest < Minitest::Test
  def test_create_instance
    testsdk = IsEvenSDK.test(nil, nil)
    ent = testsdk.NumberParity(nil)
    assert !ent.nil?
  end

  def test_basic_flow
    setup = number_parity_basic_setup(nil)
    # Per-op sdk-test-control.json skip.
    _live = setup[:live] || false
    ["load"].each do |_op|
      _should_skip, _reason = Runner.is_control_skipped("entityOp", "number_parity." + _op, _live ? "live" : "unit")
      if _should_skip
        skip(_reason || "skipped via sdk-test-control.json")
        return
      end
    end
    # The basic flow consumes synthetic IDs from the fixture. In live mode
    # without an *_ENTID env override, those IDs hit the live API and 4xx.
    if setup[:synthetic_only]
      skip "live entity test uses synthetic IDs from fixture — set ISEVEN_TEST_NUMBER_PARITY_ENTID JSON to run live"
      return
    end
    client = setup[:client]

    # Bootstrap entity data from existing test data.
    number_parity_ref01_data_raw = Vs.items(Helpers.to_map(
      Vs.getpath(setup[:data], "existing.number_parity")))
    number_parity_ref01_data = nil
    if number_parity_ref01_data_raw.length > 0
      number_parity_ref01_data = Helpers.to_map(number_parity_ref01_data_raw[0][1])
    end

    # LOAD
    number_parity_ref01_ent = client.NumberParity(nil)
    number_parity_ref01_match_dt0 = {}
    number_parity_ref01_data_dt0_loaded, err = number_parity_ref01_ent.load(number_parity_ref01_match_dt0, nil)
    assert_nil err
    assert !number_parity_ref01_data_dt0_loaded.nil?

  end
end

def number_parity_basic_setup(extra)
  Runner.load_env_local

  entity_data_file = File.join(__dir__, "..", "..", ".sdk", "test", "entity", "number_parity", "NumberParityTestData.json")
  entity_data_source = File.read(entity_data_file)
  entity_data = JSON.parse(entity_data_source)

  options = {}
  options["entity"] = entity_data["existing"]

  client = IsEvenSDK.test(options, extra)

  # Generate idmap via transform.
  idmap = Vs.transform(
    ["number_parity01", "number_parity02", "number_parity03", "iseven01", "iseven02", "iseven03"],
    {
      "`$PACK`" => ["", {
        "`$KEY`" => "`$COPY`",
        "`$VAL`" => ["`$FORMAT`", "upper", "`$COPY`"],
      }],
    }
  )

  # Detect ENTID env override before envOverride consumes it. When live
  # mode is on without a real override, the basic test runs against synthetic
  # IDs from the fixture and 4xx's. Surface this so the test can skip.
  entid_env_raw = ENV["ISEVEN_TEST_NUMBER_PARITY_ENTID"]
  idmap_overridden = !entid_env_raw.nil? && entid_env_raw.strip.start_with?("{")

  env = Runner.env_override({
    "ISEVEN_TEST_NUMBER_PARITY_ENTID" => idmap,
    "ISEVEN_TEST_LIVE" => "FALSE",
    "ISEVEN_TEST_EXPLAIN" => "FALSE",
    "ISEVEN_APIKEY" => "NONE",
  })

  idmap_resolved = Helpers.to_map(
    env["ISEVEN_TEST_NUMBER_PARITY_ENTID"])
  if idmap_resolved.nil?
    idmap_resolved = Helpers.to_map(idmap)
  end

  if env["ISEVEN_TEST_LIVE"] == "TRUE"
    merged_opts = Vs.merge([
      {
        "apikey" => env["ISEVEN_APIKEY"],
      },
      extra || {},
    ])
    client = IsEvenSDK.new(Helpers.to_map(merged_opts))
  end

  live = env["ISEVEN_TEST_LIVE"] == "TRUE"
  {
    client: client,
    data: entity_data,
    idmap: idmap_resolved,
    env: env,
    explain: env["ISEVEN_TEST_EXPLAIN"] == "TRUE",
    live: live,
    synthetic_only: live && !idmap_overridden,
    now: (Time.now.to_f * 1000).to_i,
  }
end
