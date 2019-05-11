# AltV-C# Docker Image
This is a image to run a server instance from AltV, with the latest C#-Module, in a Docker Container. It is designed to run with a volume, so that resources, config- and logfiles are persistend and mounted to the server filesystem. The container starts without example ressources and configs.

## Compose-File
The file "docker_compose.yml" creates the container and volume for you. Following command can be used to run the file:
```
docker-compose -f docker_compose.yml up
```

## Volume
The volume is structured like this:
```
Volume
    |-> resources   (place your resources here)
    |-> logs        (logfiles)
    \-> config      (place your server.cfg here)
```
Normaly the mounted volume can be found under "/var/lib/docker/volumes/altv_data/_data/"