#docker TinyMediaManager

## Description:

Smuxi is an irssi-inspired, flexible, user-friendly and cross-platform IRC client for sophisticated users. 
   
Smuxi is based on the client-server model: The core application (engine) can
be placed onto a server which is connected to the Internet around-the-clock;  
one or more frontends then connect to the core. This way, the connection to  
IRC can be kept up even when all frontends have been closed. The combination  
of screen and irssi served as example for this architecture.  

## Build from docker file:

```
git clone --depth=1 https://github.com/HurricaneHernandez/docker-smuxi.git  
cd docker-smuxi
docker build --rm=true -t Smuxi . 
```

![Alt text](http://i.imgur.com/OKQbbge.png "")

## How to use this image

### start a smuxi instance

```
docker run -d -v /*your_config_location*:/config -e TZ=America/Edmonton --name=Smuxi hurricane/smuxi
```

## Environment Variables

The Smuxi image uses serveral optional enviromnet variables.  
None of the enviromnet variables are required, but they help personalize the image.

```
USERNAME
```
This enviromnet variable is used to personalize the name of the Smuxi user. Default username is 'admin'.

```
PASSWORD
```
This environment variable is used to personalize the password of the Smuxi user. Default password is admin.

``
TZ
```
This environment variable is used to set the [TimeZone] of the container.

[TimeZone]: http://en.wikipedia.org/wiki/List_of_tz_database_time_zones

## Volumes

#### `/config`

Config directory of Smuxi.

