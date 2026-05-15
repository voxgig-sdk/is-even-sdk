<?php
declare(strict_types=1);

// IsEven SDK utility: prepare_body

class IsEvenPrepareBody
{
    public static function call(IsEvenContext $ctx): mixed
    {
        if ($ctx->op->input === 'data') {
            return ($ctx->utility->transform_request)($ctx);
        }
        return null;
    }
}
