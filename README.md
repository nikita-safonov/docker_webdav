# Host your WebDav server
## Example configuration
* Username: webdav
* Password: webdav
* Timezone: Europe/Madrid
* Port: 8080
* Host: /path/to/your_webdav_dir
* Container: /media
* --restart=unless-stopped: always running unless you stop it
## Usage
```
docker run --name webdav \
  -p 80:8080 \
  -v /path/to/your_webdav_dir:/media \
  -e USERNAME=webdav \
  -e PASSWORD=webdav \
  -e TZ=Europe/Madrid \
  -e UID=1000 \
  -e GID=1000 \
  --restart=unless-stopped \
  -d nikitasa/webdav
```
## Multiusers
Mount your own htpasswd with list of users
```
docker run --name webdav \
  -p 80:8080 \
  -v /path/to/your_webdav_dir:/media \
  -v /etc/htpasswd:/etc/nginx/htpasswd
  -e TZ=Europe/Madrid \
  -e UID=1000 \
  -e GID=1000 \
  --restart=unless-stopped \
  -d nikitasa/webdav
```
## Build your own
Clone current repository
```
git clone <this-repo-url>
```
Go to repository directory and build docker image
```
cd <repo-dir> && docker build -t nikitasa/webdav .
```