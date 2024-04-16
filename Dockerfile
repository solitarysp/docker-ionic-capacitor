FROM ubuntu:22.04

LABEL MAINTAINER="LE VAN THANH <lethanh9398@gmail.com>"

ARG JAVA_VERSION=11
ARG NODEJS_VERSION=16
# See https://developer.android.com/studio/index.html#command-tools
ARG ANDROID_SDK_VERSION=9477386
# See https://androidsdkmanager.azurewebsites.net/Buildtools
ARG ANDROID_BUILD_TOOLS_VERSION=33.0.2
# See https://developer.android.com/studio/releases/platforms
ARG ANDROID_PLATFORMS_VERSION=33
# See https://gradle.org/releases/
# ARG GRADLE_VERSION=7.4.2
# See https://www.npmjs.com/package/@ionic/cli
ARG IONIC_VERSION=6.20.8
# See https://www.npmjs.com/package/@capacitor/cli
ARG CAPACITOR_VERSION=4.6.3

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=en_US.UTF-8

WORKDIR /tmp

RUN apt-get update -q

# General packages
RUN apt-get install -qy \
    apt-utils \
    locales \
    gnupg2 \
    build-essential \
    curl \
    usbutils \
    git \
    unzip \
    p7zip p7zip-full \
    python3 \
    openjdk-${JAVA_VERSION}-jre \
    openjdk-${JAVA_VERSION}-jdk

# Set locale
RUN locale-gen en_US.UTF-8 && update-locale

# # Install Gradle
# ENV GRADLE_HOME=/opt/gradle
# RUN mkdir $GRADLE_HOME \
#     && curl -sL https://downloads.gradle-dn.com/distributions/gradle-${GRADLE_VERSION}-bin.zip -o gradle-${GRADLE_VERSION}-bin.zip \
#     && unzip -d $GRADLE_HOME gradle-${GRADLE_VERSION}-bin.zip
# ENV PATH=$PATH:/opt/gradle/gradle-${GRADLE_VERSION}/bin

# Install Android SDK tools
ENV ANDROID_HOME=/opt/android-sdk
RUN curl -sL https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_SDK_VERSION}_latest.zip -o commandlinetools-linux-${ANDROID_SDK_VERSION}_latest.zip \
    && unzip commandlinetools-linux-${ANDROID_SDK_VERSION}_latest.zip \
    && mkdir $ANDROID_HOME && mv cmdline-tools $ANDROID_HOME \
    && yes | $ANDROID_HOME/cmdline-tools/bin/sdkmanager --sdk_root=$ANDROID_HOME --licenses \
    && $ANDROID_HOME/cmdline-tools/bin/sdkmanager --sdk_root=$ANDROID_HOME "platform-tools" "build-tools;${ANDROID_BUILD_TOOLS_VERSION}" "platforms;android-${ANDROID_PLATFORMS_VERSION}"
ENV PATH=$PATH:${ANDROID_HOME}/cmdline-tools:${ANDROID_HOME}/platform-tools

# Install NodeJS
RUN curl -sL https://deb.nodesource.com/setup_${NODEJS_VERSION}.x | bash - \
    && apt-get update -q && apt-get install -qy nodejs
ENV NPM_CONFIG_PREFIX=${HOME}/.npm-global
ENV PATH=$PATH:${HOME}/.npm-global/bin

# Install Ionic CLI and Capacitor CLI
RUN npm install -g @ionic/cli@${IONIC_VERSION} \
    && npm install -g @capacitor/cli@${CAPACITOR_VERSION}

RUN npm install -g yarn

################################################################################################
###
### Install Ruby & bundler
###
RUN apt-get install -y ruby ruby-dev ruby-bundler build-essential
################################################################################################
###
### Install Fastlane and plugins
###

RUN gem install fastlane -NV \
  && gem install fastlane-plugin-appicon fastlane-plugin-android_change_string_app_name fastlane-plugin-humanable_build_number


# Clean up
RUN apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/*

WORKDIR /workdir
