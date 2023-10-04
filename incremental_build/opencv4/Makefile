OPENCV_VERSION?=4.7.0

download:
	mkdir -p debug; cd debug && \
	git clone --depth 1 -b $(OPENCV_VERSION) https://github.com/opencv/opencv source|| true; \
	git clone --depth 1 -b $(OPENCV_VERSION) https://github.com/opencv/opencv_contrib || true; \
	mv opencv_contrib/modules source/opencv_contrib
