cd ./cron/
tar -xzvf ./previewgenerator.tar.gz
docker build -t nextcloud:image-preview .
cd -
docker-compose up -d
