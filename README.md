> A lightweight Docker image to build Android APKs from Python/Kivy using Buildozer. Includes Python 3.10, Android SDK, and all required dependencies for cross-compilation.
# Buildozer Docker Image for Kivy & Python to Build Android APKs (Python 3.10)
![Docker](https://img.shields.io/badge/docker-ready-blue)
![Buildozer](https://img.shields.io/badge/buildozer-supported-green)
![Python](https://img.shields.io/badge/python-3.10-blue)

This Docker image provides a fully pre-configured environment for building Android APKs using [Buildozer](https://github.com/kivy/buildozer). It includes Python 3.10, Android SDK, required 32-bit libraries, and common Python build tools.

## What’s Inside?

- Python 3.10
- OpenJDK 17
- Android SDK (API 31 & Build Tools 31.0.0)
- Required 32-bit libraries for Android builds
- Buildozer + Cython
- pip tools: setuptools, wheel, jinja2, toml, etc.

## Getting Started

### 1. Build the Docker image
Make sure your Kivy project (with main.py and buildozer.spec) is in the current directory:
```bash
docker build -t buildozer:android .
```
### 2. Initialize Buildozer (first time only)
If you don't have a buildozer.spec file yet, initialize it:
```bash
docker run --rm -v $(pwd):/app -w /app buildozer:android init
```
### 3. Build your APK (with SDK cache preserved)
```bash
docker run -it --rm -v $(pwd):/app -w /app -v "$HOME/.buildozer":/root/.buildozer buildozer:android -v android debug
```
### 4. Find your APK
Your APK will be located in:
```bash
./bin/
```

## 🙌 Contribute

This project is open for improvements!  
Feel free to open a pull request or issue if you'd like to:

- Add support for other Android API levels
- Add caching or build optimizations
- Add new Python or system packages
- Improve documentation

Even simple ideas or fixes are very welcome!

