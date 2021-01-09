all: build
build:
	docker run \
			-it \
			--rm \
			-p 80:4000 \
			-w /lab \
			-v ${PWD}:/lab \
			fellah/gitbook bash -c './build.sh'
