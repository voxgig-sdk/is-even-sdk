# IsEven Python SDK Reference

Complete API reference for the IsEven Python SDK.


## IsEvenSDK

### Constructor

```python
from is-even_sdk import IsEvenSDK

client = IsEvenSDK(options)
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `dict` | SDK configuration options. |
| `options["apikey"]` | `str` | API key for authentication. |
| `options["base"]` | `str` | Base URL for API requests. |
| `options["prefix"]` | `str` | URL prefix appended after base. |
| `options["suffix"]` | `str` | URL suffix appended after path. |
| `options["headers"]` | `dict` | Custom headers for all requests. |
| `options["feature"]` | `dict` | Feature configuration. |
| `options["system"]` | `dict` | System overrides (e.g. custom fetch). |


### Static Methods

#### `IsEvenSDK.test(testopts=None, sdkopts=None)`

Create a test client with mock features active. Both arguments may be `None`.

```python
client = IsEvenSDK.test()
```


### Instance Methods

#### `NumberParity(data=None)`

Create a new `NumberParityEntity` instance. Pass `None` for no initial data.

#### `options_map() -> dict`

Return a deep copy of the current SDK options.

#### `get_utility() -> Utility`

Return a copy of the SDK utility object.

#### `direct(fetchargs=None) -> tuple`

Make a direct HTTP request to any API endpoint. Returns `(result, err)`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `str` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `str` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `dict` | Path parameter values. |
| `fetchargs["query"]` | `dict` | Query string parameters. |
| `fetchargs["headers"]` | `dict` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `any` | Request body (dicts are JSON-serialized). |

**Returns:** `(result_dict, err)`

#### `prepare(fetchargs=None) -> tuple`

Prepare a fetch definition without sending. Returns `(fetchdef, err)`.


---

## NumberParityEntity

```python
number_parity = client.NumberParity()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `ad` | ``$STRING`` | No |  |
| `iseven` | ``$BOOLEAN`` | Yes |  |

### Operations

#### `load(reqmatch, ctrl=None) -> tuple`

Load a single entity matching the given criteria.

```python
result, err = client.NumberParity().load({"id": "number_parity_id"})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `NumberParityEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```python
client = IsEvenSDK({
    "feature": {
        "test": {"active": True},
    },
})
```

