// https://lindevs.com/install-precompiled-opencv-on-raspberry-pi/
// compileren met --> g++ main.cpp -o opencv_test -lopencv_core


#include <opencv2/opencv.hpp>
 
int main() {
    std::cout << cv::getBuildInformation() << std::endl;
 
    return 0;
}
