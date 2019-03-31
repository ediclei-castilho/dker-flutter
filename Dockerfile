FROM ubuntu
#FROM openjdk:8-alpine 

# ARG ANDROID_SDK_VERSION=4333796
# ENV ANDROID_HOME /opt/android-sdk
# RUN mkdir -p ${ANDROID_HOME} && cd ${ANDROID_HOME} && \
#     wget -q https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_VERSION}.zip && \
#     unzip *tools*linux*.zip && \
#     rm *tools*linux*.zip


# RUN PATH=${PATH}:/opt/android-sdk/tools:/opt/android-sdk/tools/

# ###############

ENV FLUTTER_HOME /root/flutter
ENV FLUTTER_VERSION 1.0.0-stable

RUN apt-get update \
  && apt-get install -y libglu1-mesa git curl unzip wget xz-utils lib32stdc++6 \
  && apt-get clean

RUN wget -q https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_v${FLUTTER_VERSION}.tar.xz
RUN mkdir $FLUTTER_HOME
RUN cd $FLUTTER_HOME/../ && \
	tar xf /flutter_linux_v1.0.0-stable.tar.xz

#RUN PATH=${PATH}:${FLUTTER_HOME}/bin
ENV PATH $PATH:$FLUTTER_HOME/bin/cache/dart-sdk/bin:$FLUTTER_HOME/bin

RUN flutter doctor
