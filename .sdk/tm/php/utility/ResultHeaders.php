<?php
declare(strict_types=1);

// IsEven SDK utility: result_headers

class IsEvenResultHeaders
{
    public static function call(IsEvenContext $ctx): ?IsEvenResult
    {
        $response = $ctx->response;
        $result = $ctx->result;
        if ($result) {
            if ($response && is_array($response->headers)) {
                $result->headers = $response->headers;
            } else {
                $result->headers = [];
            }
        }
        return $result;
    }
}
