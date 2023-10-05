OPENCV_VERSION?=4.7.0

download:
	mkdir -p stage1; cd stage1 && \
	git clone --depth 1 -b $(OPENCV_VERSION) https://github.com/opencv/opencv source|| true; \
	git clone --depth 1 -b $(OPENCV_VERSION) https://github.com/opencv/opencv_contrib &&  \
	mv opencv_contrib/modules source/opencv_contrib

PHONY: stage1-build
stage1-build:
	nix-build -A opencv

stage2:
	nix-shell
