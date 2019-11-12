all: container

astron:
	git clone https://github.com/Astron/Astron astron
container: astron
	docker build -t winadam:astron .

run: container
	docker run  -it -p 7199:7199 -p 6667:6667 -v `pwd`/astrond.yml:/opt/astron/astrond.yml winadam:astron  -L packet /opt/astron/astrond.yml




