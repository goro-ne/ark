pwd = $(shell pwd)

build:
	docker build -t perl-dev .

bash:
	docker run -v $(pwd):/myapp -it perl-dev /bin/bash

install:
	docker run -v $(pwd):/myapp --entrypoint carton -t perl-dev

plackup:
	docker run -v $(pwd):/myapp -p 5000:5000 -it perl-dev plackup -r dev.psgi
