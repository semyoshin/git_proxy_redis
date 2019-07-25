# GITHUB Proxy with Redis support

*Docker and Docker-Compose are required*
1. Clone the app

2. Set redis server's IP (Host network IP or docker gateway) in default file:
```
local ok, err = red:connect("172.24.0.1", 6379)
```
3. Run the app, wait until image will be built in first run:
```
sudo docker-compose up -d
```
4. Set the token:token key value in redis:
```
sudo docker exec -it redis sh -c "redis-cli set token 'https://githubtoken:x-oauth-basic@github.com/some/private/repo/on/github.git'"
sudo docker exec -it redis sh -c "redis-cli get token"
```
5. Clone the private repo:
```
git clone http://token@localhost/some/private/repo/on/github.git/
```
