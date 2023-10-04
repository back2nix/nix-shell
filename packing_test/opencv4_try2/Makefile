OPENCV_VERSION?=4.7.0

download:
	git clone --depth 1 -b $(OPENCV_VERSION) https://github.com/opencv/opencv -o opencv || true
	git clone --depth 1 -b $(OPENCV_VERSION) https://github.com/opencv/opencv_contrib -o opencv_contrib || true
	mv opencv_contrib/modules opencv/opencv_contrib
