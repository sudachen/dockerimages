
%.Build: %.Dockerfile
	docker build -t sudachen/$(basename $@) -f $^ .

%.Push : %.Build
	docker push sudachen/$(basename $@)

ALL = linux go1144 go1144-ci linux-ci

build: $(foreach i,$(ALL),$(basename $(i)).Build)
push: $(foreach i,$(ALL),$(basename $(i)).Push)


