<?php
declare(strict_types=1);

// IsEven SDK utility: feature_add

class IsEvenFeatureAdd
{
    public static function call(IsEvenContext $ctx, mixed $f): void
    {
        $ctx->client->features[] = $f;
    }
}
