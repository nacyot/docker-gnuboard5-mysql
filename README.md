# docker-gnuboard5-mysql

This is Dockerfile for building
[Gnuboard5](http://sir.co.kr/) application
image. This Dockerfile based on Gnuboard 5.0b16.

# Building Docker Image from Dockerfile

1. Clone this repository.

```sh
$ git clone https://github.com/nacyot/docker-gnuboard5-mysql.git
$ cd docker-gnuboard5-mysql
```

1. Building image from Dockerfile.

```sh
$ docker build -t nacyot/gnuboard5-mysql .
```

# Starting Server(Docker Container)

```
$ docker run -d -p <PUBLIC_PORT>:80 nacyot/gnuboard5-mysql
```

Replace `<PUBLIC_PORT>` with the number. You can access your Gnuboard5
application on `http://127.0.0.1:<PUBLIC_PORT>/gnuboard5`

# Installing Gnuboard5

Open `http://127.0.0.1:<PUBLIC_PORT>/gnuboard5`, install gnuboard5.

## Mysql Default Account

In Gnuboard5 installation, input below database information.

```
ID : gnuboard
Password : gnub0ard
Database : gnuboard
```

# Setting up Nginx Proxy

```nginx
upstream gnuboard5_server {
  server 127.0.0.1:<PUBILC_PORT>;


server {
  server_name <YOUR_DOMAIN>;

  location / {
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header Host $http_host;
    proxy_redirect off;
    proxy_pass http://gnuboard5_server;
  }
}
```

# Author
Daekwon Kim(nacyot) <propellerheaven@gmail.com>.

# License
The MIT License (MIT)

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
