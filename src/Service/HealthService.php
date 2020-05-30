<?php

namespace App\Service;

use Grpc\Health\V1\HealthCheckRequest;
use Grpc\Health\V1\HealthCheckResponse;
use Grpc\Health\V1\HealthCheckResponse_ServingStatus;
use Grpc\Health\V1\HealthInterface;
use Spiral\GRPC;

class HealthService implements HealthInterface
{
    public function Check(GRPC\ContextInterface $ctx, HealthCheckRequest $in): HealthCheckResponse
    {
        return (new HealthCheckResponse())->setStatus(HealthCheckResponse_ServingStatus::SERVING);
    }
}
