#!/bin/bash

export IMAGE_VERSION=1.1
export IMAGE_NAME=metjusinio/sales_app
export IMAGE=$IMAGE_NAME:$IMAGE_VERSION

REPO_HOST_DIR=`pwd`

container_running () {
  container_id=$(docker ps -q -f name=devenv)
  container_id_length=${#container_id}

  echo $container_id_length
}

remove_and_stop_devenv () {

  container_id=$(docker ps -q -a -f name=devenv)
  container_id_length=${#container_id}
  if [[ $container_id_length > 0 ]]; then
    docker stop devenv
    docker rm devenv
  fi
}

echo "Using production image $IMAGE"

if [ "$1" == "build" ]; then

  docker build -t $IMAGE .

elif [ "$1" == "pull" ]; then

  docker pull $IMAGE

elif [ "$1" == "push" ]; then

  docker push $IMAGE

elif [ "$1" == "commit" ]; then

  docker commit devenv $IMAGE_NAME:$2
  sed -i "3s/.*/export IMAGE_VERSION=$2/" ./dev.sh

elif [ "$1" == "bash" ]; then

  running_container=$(container_running)
  echo $running_container

  if [[ $running_container > 0 ]]; then
    docker exec -it devenv bash
  else
    docker run -it --name devenv -w="/project" -u $(id -u):$(id -g) -p 8888:8888 -v "$REPO_HOST_DIR":/project $IMAGE bash
  fi

elif [ "$1" == "app" ]; then

  running_container=$(container_running)

  xdg-open http://localhost:8888 > /dev/null
  if [[ $running_container > 0 ]]; then
    docker exec -it devenv R -e "shiny::shinyAppDir('/project')"
  else
    docker run -it --name devenv -w="/project" -u $(id -u):$(id -g) -p 8888:8888 -v "$REPO_HOST_DIR":/project $IMAGE R -e "shiny::shinyAppDir('/project')"
  fi

  echo "App running at: http://localhost:8888 (Ctrl + C Terminal to stop)"

elif [ "$1" == "stop" ]; then

  remove_and_stop_devenv
  echo "Container devenv stopped and removed"

else
  echo "Usage: ./workflow.sh [param]"
  echo
  echo "Params:"
  echo
  echo "   build - build image from Dockerfile"
  echo "   pull - get images from Docker Hub"
  echo "   push - push images to Docker Hub"
  echo "   run - run development image terminal"
  echo "   stop - stop running container"
  echo "   app - run containerized application"
  echo
fi
