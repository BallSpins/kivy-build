FROM python:3.10

ENV HOME=/root

# Install dependencies
RUN dpkg --add-architecture i386 && apt update && apt install -y \
    openjdk-17-jdk \
    git zip unzip wget curl \
    build-essential ccache libffi-dev \
    libssl-dev libncurses5:i386 libstdc++6:i386 zlib1g:i386 \
    libncurses5-dev libsqlite3-dev libpng-dev libjpeg-dev \
    libfreetype6-dev libgl1-mesa-dev libgles2-mesa-dev \
    libsndfile1 liblzma-dev \
    && rm -rf /var/lib/apt/lists/*

# Install pip packages
RUN pip install --upgrade pip && pip install \
    buildozer \
    'cython<3.0' \
    appdirs \
    setuptools \ 
    wheel \
    packaging \ 
    colorama \
    six \ 
    jinja2 \
    toml \
    build

# Set up Android SDK
ENV ANDROID_HOME=/root/.buildozer/android/platform/android-sdk
ENV PATH=$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$PATH
ENV USE_CCACHE=0

RUN mkdir -p $ANDROID_HOME/cmdline-tools \
 && cd $ANDROID_HOME/cmdline-tools \
 && wget https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip -O tools.zip \
 && unzip tools.zip -d temp \
 && mv temp/cmdline-tools $ANDROID_HOME/cmdline-tools/latest \
 && rm -rf tools.zip

# Install Android SDK components
RUN yes | sdkmanager --sdk_root=$ANDROID_HOME \
    "platform-tools" "platforms;android-31" "build-tools;31.0.0"

# Final setup
WORKDIR /app
ENTRYPOINT ["buildozer"]

