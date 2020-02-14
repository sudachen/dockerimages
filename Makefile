
%.Build: %.Dockerfile
	docker build -t sudachen/$(basename $@) -f $^ .

%.Push : %.Build
	docker push sudachen/$(basename $@)

ALL = linux go1127 go1127-ci go1137 go1137-ci

build: $(foreach i,$(ALL),$(basename $(i)).Build)
push: $(foreach i,$(ALL),$(basename $(i)).Push)

