FROM ubuntu

ENV FLUTTER_HOME /root/flutter
ENV FLUTTER_VERSION 1.2.1-stable

ENV ANDROID_SDK_HOME /opt/sdk
ENV ANDROID_SDK_VERSION 4333796
ENV ANDROID_SDK_ROOT /opt/sdk

RUN mkdir $FLUTTER_HOME && \
    mkdir $ANDROID_SDK_HOME && \
    mkdir -p $ANDROID_SDK_HOME/.android && \
    touch $ANDROID_SDK_HOME/.android/repositories.cfg

RUN apt-get update && \
  apt-get install -y libglu1-mesa git curl unzip wget xz-utils lib32stdc++6 && \
  apt-get clean

RUN wget -q https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_v${FLUTTER_VERSION}.tar.xz

RUN cd $FLUTTER_HOME/../ && \
	tar xf /flutter_linux_v$FLUTTER_VERSION.tar.xz

RUN apt-get update && \
	apt-get install -y openjdk-8-jdk && \
	apt-get install -y ant && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /var/cache/oracle-jdk8-installer;
	
RUN apt-get update && \
	apt-get install -y ca-certificates-java && \
	apt-get clean && \
	update-ca-certificates -f && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /var/cache/oracle-jdk8-installer;

RUN apt-get update && \
  apt-get install -y unzip wget && \
  apt-get clean

RUN cd $ANDROID_SDK_HOME && \
    wget https://dl.google.com/android/repository/sdk-tools-linux-$ANDROID_SDK_VERSION.zip
RUN cd $ANDROID_SDK_HOME && \
    unzip sdk*$ANDROID_SDK_VERSION.zip && \
    rm sdk*$ANDROID_SDK_VERSION.zip
    
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
RUN export JAVA_HOME
RUN export ANDROID_SDK_ROOT
ENV PATH $PATH:$JAVA_HOME/bin:$ANDROID_SDK_HOME/tools:$ANDROID_SDK_HOME/tools/bin:$ANDROID_SDK_ROOT
ENV PATH $PATH:$FLUTTER_HOME/bin/cache/dart-sdk/bin:$FLUTTER_HOME/bin

RUN flutter config --android-sdk $ANDROID_SDK_ROOT
RUN flutter doctor
RUN java -version
RUN sdkmanager --list