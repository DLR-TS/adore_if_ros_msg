ARG PROJECT

FROM ros:noetic-ros-core-focal AS adore_if_ros_msg_requirements_base

ARG PROJECT
ARG REQUIREMENTS_FILE="requirements.${PROJECT}.ubuntu20.04.system"


WORKDIR /tmp/${PROJECT}
copy files/${REQUIREMENTS_FILE} /tmp/${PROJECT}

RUN apt-get update && \
    apt-get install --no-install-recommends -y checkinstall && \
    xargs apt-get install --no-install-recommends -y < ${REQUIREMENTS_FILE} && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /tmp/${PROJECT}
COPY ${PROJECT} /tmp/${PROJECT}


FROM adore_if_ros_msg_requirements_base AS adore_if_ros_msg_builder

ARG PROJECT

WORKDIR /tmp/${PROJECT}
RUN mkdir -p build 
SHELL ["/bin/bash", "-c"]
WORKDIR /tmp/${PROJECT}/build

#cmake .. -DCATKIN_DEVEL_PREFIX="/tmp/${PROJECT}/build/install" && \

RUN source /opt/ros/noetic/setup.bash && \
    cmake .. && \
    cmake --build .  --config Release --target install -- -j $(nproc) && \
    cpack -G DEB && find . -type f -name "*.deb" | xargs mv -t . && \
    cd /tmp/${PROJECT}/build && ln -s devel install && \
    mv CMakeCache.txt CMakeCache.txt.build

#RUN source /opt/ros/noetic/setup.bash && \
#    cmake .. -DBUILD_adore_TESTING=ON -DCMAKE_PREFIX_PATH=install -DCMAKE_INSTALL_PREFIX:PATH=install && \
#    cmake --build . --config Release --target install -- -j $(nproc) && \
#    cpack -G DEB && find . -type f -name "*.deb" | xargs mv -t . 


#FROM alpine:3.14

#ARG PROJECT
#COPY --from=adore_if_ros_msg_builder /tmp/${PROJECT} /tmp/${PROJECT}

