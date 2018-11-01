TAG=`date "+%Y%m%d"`
docker build -t sigven/2020plus:$TAG --rm=true .
