# docker-ionic-capacitor

🐳 Docker image for building Ionic apps with Capacitor. 

## How to use this image

<!-- ### Pull image

Pull from Docker Registry:  
`docker pull lethanh9398/docker-ionic-capacitor-fastlane` -->

### Build image

Build from GitHub:  
```
docker build -t lethanh9398/docker-ionic-capacitor-fastlane .
```

Available build arguments:  

- JAVA_VERSION (Default: `11`)
- NODEJS_VERSION (Default: `16`)
- ANDROID_SDK_VERSION (Default: `9477386`)
- ANDROID_BUILD_TOOLS_VERSION (Default: `33.0.0`)
- ANDROID_PLATFORMS_VERSION (Default: `32`)
- GRADLE_VERSION (Default: `7.4.2`)
- IONIC_VERSION (Default: `6.20.8`)
- CAPACITOR_VERSION (Default: `4.6.3`)

### Run image

Run the docker image:  
```
docker run -it robingenz/ionic-capacitor bash
```

## Questions / Issues

If you got any questions or problems using the image, please visit my [GitHub Repository](https://github.com/robingenz/docker-ionic-capacitor) and write an issue.
