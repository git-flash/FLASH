docker container prune -f
docker-compose -f docker-compose-test.yml build
docker-compose -f docker-compose-test.yml up
