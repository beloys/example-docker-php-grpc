# Playground of gRPC communication in PHP

Start container
`docker-compose up`

Install dependencies
`docker-compose exec -T grpc bash -c 'composer install`

Generate messages and clients
`docker-compose exec -T grpc bash -c 'composer proto:generate`

Start gRPC server
`docker-compose exec -T grpc bash -c 'rr-grpc serve -v -d'`

Demo request
`docker-compose exec -T grpc bash -c 'php client.php'`
