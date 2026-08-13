package sdktest

import (
	"encoding/json"
	"os"
	"path/filepath"
	"runtime"
	"strings"
	"testing"
	"time"

	sdk "github.com/voxgig-sdk/is-even-sdk/go"
	"github.com/voxgig-sdk/is-even-sdk/go/core"

	vs "github.com/voxgig-sdk/is-even-sdk/go/utility/struct"
)

func TestNumberParityEntity(t *testing.T) {
	t.Run("instance", func(t *testing.T) {
		testsdk := sdk.TestSDK(nil, nil)
		ent := testsdk.NumberParity(nil)
		if ent == nil {
			t.Fatal("expected non-nil NumberParityEntity")
		}
	})

	t.Run("basic", func(t *testing.T) {
		setup := number_parityBasicSetup(nil)
		// Per-op sdk-test-control.json skip — basic test exercises a flow
		// with multiple ops; skipping any op skips the whole flow.
		_mode := "unit"
		if setup.live {
			_mode = "live"
		}
		for _, _op := range []string{"load"} {
			if _shouldSkip, _reason := isControlSkipped("entityOp", "number_parity." + _op, _mode); _shouldSkip {
				if _reason == "" {
					_reason = "skipped via sdk-test-control.json"
				}
				t.Skip(_reason)
				return
			}
		}
		// The basic flow consumes synthetic IDs from the fixture. In live mode
		// without an *_ENTID env override, those IDs hit the live API and 4xx.
		if setup.syntheticOnly {
			t.Skip("live entity test uses synthetic IDs from fixture — set IS_EVEN_TEST_NUMBER_PARITY_ENTID JSON to run live")
			return
		}
		client := setup.client

		// Bootstrap entity data from existing test data (no create step in flow).
		numberParityRef01DataRaw := vs.Items(core.ToMapAny(vs.GetPath("existing.number_parity", setup.data)))
		var numberParityRef01Data map[string]any
		if len(numberParityRef01DataRaw) > 0 {
			numberParityRef01Data = core.ToMapAny(numberParityRef01DataRaw[0][1])
		}
		// Discard guards against Go's unused-var check when the flow's steps
		// happen not to consume the bootstrap data (e.g. list-only flows).
		_ = numberParityRef01Data

		// LOAD
		numberParityRef01Ent := client.NumberParity(nil)
		numberParityRef01MatchDt0 := map[string]any{}
		numberParityRef01DataDt0Loaded, err := numberParityRef01Ent.Load(numberParityRef01MatchDt0, nil)
		if err != nil {
			t.Fatalf("load failed: %v", err)
		}
		if numberParityRef01DataDt0Loaded == nil {
			t.Fatal("expected load result to be non-nil")
		}

	})
}

func number_parityBasicSetup(extra map[string]any) *entityTestSetup {
	loadEnvLocal()

	_, filename, _, _ := runtime.Caller(0)
	dir := filepath.Dir(filename)

	entityDataFile := filepath.Join(dir, "..", "..", ".sdk", "test", "entity", "number_parity", "NumberParityTestData.json")

	entityDataSource, err := os.ReadFile(entityDataFile)
	if err != nil {
		panic("failed to read number_parity test data: " + err.Error())
	}

	var entityData map[string]any
	if err := json.Unmarshal(entityDataSource, &entityData); err != nil {
		panic("failed to parse number_parity test data: " + err.Error())
	}

	options := map[string]any{}
	options["entity"] = entityData["existing"]

	client := sdk.TestSDK(options, extra)

	// Generate idmap via transform, matching TS pattern.
	idmap := vs.Transform(
		[]any{"number_parity01", "number_parity02", "number_parity03", "iseven01", "iseven02", "iseven03"},
		map[string]any{
			"`$PACK`": []any{"", map[string]any{
				"`$KEY`": "`$COPY`",
				"`$VAL`": []any{"`$FORMAT`", "upper", "`$COPY`"},
			}},
		},
	)

	// Detect ENTID env override before envOverride consumes it. When live
	// mode is on without a real override, the basic test runs against synthetic
	// IDs from the fixture and 4xx's. Surface this so the test can skip.
	entidEnvRaw := os.Getenv("IS_EVEN_TEST_NUMBER_PARITY_ENTID")
	idmapOverridden := entidEnvRaw != "" && strings.HasPrefix(strings.TrimSpace(entidEnvRaw), "{")

	env := envOverride(map[string]any{
		"IS_EVEN_TEST_NUMBER_PARITY_ENTID": idmap,
		"IS_EVEN_TEST_LIVE":      "FALSE",
		"IS_EVEN_TEST_EXPLAIN":   "FALSE",
	})

	idmapResolved := core.ToMapAny(env["IS_EVEN_TEST_NUMBER_PARITY_ENTID"])
	if idmapResolved == nil {
		idmapResolved = core.ToMapAny(idmap)
	}

	if env["IS_EVEN_TEST_LIVE"] == "TRUE" {
		mergedOpts := vs.Merge([]any{
			map[string]any{
			},
			extra,
		})
		client = sdk.NewIsEvenSDK(core.ToMapAny(mergedOpts))
	}

	live := env["IS_EVEN_TEST_LIVE"] == "TRUE"
	return &entityTestSetup{
		client:        client,
		data:          entityData,
		idmap:         idmapResolved,
		env:           env,
		explain:       env["IS_EVEN_TEST_EXPLAIN"] == "TRUE",
		live:          live,
		syntheticOnly: live && !idmapOverridden,
		now:           time.Now().UnixMilli(),
	}
}
