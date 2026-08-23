<?php
declare(strict_types=1);

// IsEven SDK configuration

class IsEvenConfig
{
    /** @var array<string,mixed>|null */
    private static ?array $shared_config = null;

    /**
     * Return the process-wide config, built once on first use. The SDK reads
     * the config on every request and never writes to it, so one instance is
     * shared by every client rather than rebuilt per client.
     *
     * PHP arrays are copy-on-write, so callers that do mutate the result get
     * their own copy and cannot disturb the shared one.
     */
    public static function shared_config(): array
    {
        if (self::$shared_config === null) {
            self::$shared_config = self::make_config();
        }
        return self::$shared_config;
    }

    /**
     * Build a fresh, fully materialised config array. Every call rebuilds the
     * whole structure, so prefer shared_config unless you need a private copy.
     */
    public static function make_config(): array
    {
        return [
            "main" => [
                "name" => "IsEven",
                "slug" => "is-even",
                "version" => "0.0.1",
                "target" => "php",
            ],
            "feature" => [
                "test" => [
          'options' => [
            'active' => false,
          ],
        ],
            ],
            "options" => [
                "base" => "https://api.isevenapi.xyz/api",
                "headers" => [
          'content-type' => 'application/json',
        ],
                "entity" => [
                    "number_parity" => [],
                ],
            ],
            "entity" => [
        'number_parity' => [
          'fields' => [
            [
              'name' => 'ad',
              'short' => 'Advertisement text (present in free tier, removed in Premium and Enterprise tiers)',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'iseven',
              'req' => true,
              'short' => 'True if the number is even, false if odd',
              'type' => '`$BOOLEAN`',
            ],
          ],
          'name' => 'number_parity',
          'op' => [
            'load' => [
              'input' => 'data',
              'name' => 'load',
              'points' => [
                [
                  'args' => [
                    'params' => [
                      [
                        'example' => 6,
                        'kind' => 'param',
                        'name' => 'number',
                        'orig' => 'number',
                        'reqd' => true,
                        'type' => '`$INTEGER`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/iseven/{number}/',
                  'parts' => [
                    'iseven',
                    '{number}',
                  ],
                  'select' => [
                    'exist' => [
                      'number',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                ],
              ],
            ],
          ],
          'relations' => [
            'ancestors' => [
              [
                'iseven',
              ],
            ],
          ],
        ],
      ],
        ];
    }


    public static function make_feature(string $name)
    {
        require_once __DIR__ . '/features.php';
        return IsEvenFeatures::make_feature($name);
    }
}
