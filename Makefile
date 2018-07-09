all: container

astron:
	git clone https://github.com/Astron/Astron astron
container: astron
	docker build -t winadam:astron .



