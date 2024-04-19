function minikube-env
    eval (minikube docker-env -p minikube)
    set -gx DOCKER_MACHINE_NAME minikube
end
