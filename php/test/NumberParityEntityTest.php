<?php
declare(strict_types=1);

// NumberParity entity test

require_once __DIR__ . '/../iseven_sdk.php';
require_once __DIR__ . '/Runner.php';

use PHPUnit\Framework\TestCase;
use Voxgig\Struct\Struct as Vs;

class NumberParityEntityTest extends TestCase
{
    public function test_create_instance(): void
    {
        $testsdk = IsEvenSDK::test(null, null);
        $ent = $testsdk->NumberParity(null);
        $this->assertNotNull($ent);
    }

    public function test_basic_flow(): void
    {
        $setup = number_parity_basic_setup(null);
        // Per-op sdk-test-control.json skip.
        $_live = !empty($setup["live"]);
        foreach (["load"] as $_op) {
            [$_shouldSkip, $_reason] = Runner::is_control_skipped("entityOp", "number_parity." . $_op, $_live ? "live" : "unit");
            if ($_shouldSkip) {
                $this->markTestSkipped($_reason ?? "skipped via sdk-test-control.json");
                return;
            }
        }
        // The basic flow consumes synthetic IDs from the fixture. In live mode
        // without an *_ENTID env override, those IDs hit the live API and 4xx.
        if (!empty($setup["synthetic_only"])) {
            $this->markTestSkipped("live entity test uses synthetic IDs from fixture — set IS_EVEN_TEST_NUMBER_PARITY_ENTID JSON to run live");
            return;
        }
        $client = $setup["client"];

        // Bootstrap entity data from existing test data.
        $number_parity_ref01_data_raw = Vs::items(Helpers::to_map(
            Vs::getpath($setup["data"], "existing.number_parity")));
        $number_parity_ref01_data = null;
        if (count($number_parity_ref01_data_raw) > 0) {
            $number_parity_ref01_data = Helpers::to_map($number_parity_ref01_data_raw[0][1]);
        }

        // LOAD
        $number_parity_ref01_ent = $client->NumberParity(null);
        $number_parity_ref01_match_dt0 = [];
        $number_parity_ref01_data_dt0_loaded = $number_parity_ref01_ent->load($number_parity_ref01_match_dt0, null);
        $this->assertNotNull($number_parity_ref01_data_dt0_loaded);

    }
}

function number_parity_basic_setup($extra)
{
    Runner::load_env_local();

    $entity_data_file = __DIR__ . '/../../.sdk/test/entity/number_parity/NumberParityTestData.json';
    $entity_data_source = file_get_contents($entity_data_file);
    $entity_data = json_decode($entity_data_source, true);

    $options = [];
    $options["entity"] = $entity_data["existing"];

    $client = IsEvenSDK::test($options, $extra);

    // Generate idmap.
    $idmap = [];
    foreach (["number_parity01", "number_parity02", "number_parity03", "iseven01", "iseven02", "iseven03"] as $k) {
        $idmap[$k] = strtoupper($k);
    }

    // Detect ENTID env override before envOverride consumes it. When live
    // mode is on without a real override, the basic test runs against synthetic
    // IDs from the fixture and 4xx's. Surface this so the test can skip.
    $entid_env_raw = getenv("IS_EVEN_TEST_NUMBER_PARITY_ENTID");
    $idmap_overridden = $entid_env_raw !== false && str_starts_with(trim($entid_env_raw), "{");

    $env = Runner::env_override([
        "IS_EVEN_TEST_NUMBER_PARITY_ENTID" => $idmap,
        "IS_EVEN_TEST_LIVE" => "FALSE",
        "IS_EVEN_TEST_EXPLAIN" => "FALSE",
    ]);

    $idmap_resolved = Helpers::to_map(
        $env["IS_EVEN_TEST_NUMBER_PARITY_ENTID"]);
    if ($idmap_resolved === null) {
        $idmap_resolved = Helpers::to_map($idmap);
    }

    if ($env["IS_EVEN_TEST_LIVE"] === "TRUE") {
        $merged_opts = Vs::merge([
            [
            ],
            $extra ?? [],
        ]);
        $client = new IsEvenSDK(Helpers::to_map($merged_opts));
    }

    $live = $env["IS_EVEN_TEST_LIVE"] === "TRUE";
    return [
        "client" => $client,
        "data" => $entity_data,
        "idmap" => $idmap_resolved,
        "env" => $env,
        "explain" => $env["IS_EVEN_TEST_EXPLAIN"] === "TRUE",
        "live" => $live,
        "synthetic_only" => $live && !$idmap_overridden,
        "now" => (int)(microtime(true) * 1000),
    ];
}
