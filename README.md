# AltV-C# Docker Image
This is a image to run a server instance from AltV, with the latest C#-Module, in a Docker Container. It is designed to run with a volume, so that resources, config- and logfiles are persistend and mounted to the server filesystem. The container starts without example ressources and configs.

## Compose-File
The file "docker-compose.yml" creates the container and volume for you. Following command can be used to run the file:
```
docker-compose up -d
```

## Volume
The volume is structured like this:
```
Volume
    |-> resources   (place your resources here)
    |-> resources-data  (here you can place data generated by your resources)
    |-> logs        (logfiles)
    \-> config      (place your server.cfg here)
```
Normaly the mounted volume can be found under "/var/lib/docker/volumes/altv-csharp_data/_data/"
