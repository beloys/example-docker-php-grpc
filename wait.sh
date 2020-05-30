#!/bin/sh

echo "Usage:";
echo "   docker-compose exec grpc bash    - Execute bash";
echo "   composer install                 - Install dependencies";
echo "   composer proto:generate          - Generate messages and clients";
echo "   rr-grpc serve -d -v              - Start RoadRunner gRPC server";
echo "   php client.php                   - Test request command";

while true
do
 sleep 1
done
