# AcousticBrainz Android Client
# Installing
To use the client, you need to add the `acousticbrainz` package as a gradle dependency.
1) Github Package Registry requires authentication to access a package. Follow the official docs to generate an authentication token. You can store this authentiation token and your github username as system variables or in your a properties file in your project. Here is an example to the `local.properties` file at the root of the project append the following lines.     

**local.properties**
```Java Properties
github.token=GITHUB_AUTH_TOKEN
github.username=GITHUB_USERNAME
```

2) To your project level `build.gradle` file, add the Github Maven Package Registry repo for this project.  

**build.gradle**
```Gradle
maven {
	url = 'https://maven.pkg.github.com/metabrainz/acousticbrainz-android'
	credentials {
		Properties properties = new Properties()
		properties.load(project.rootProject.file('local.properties').newDataInputStream())
		username properties.getProperty('github.username')
		password properties.getProperty('github.token')
	}
}
```
3) To the module level `build.gradle` file of the module, you want to use acousticbrainz client with, add the following line.

**app/build.gradle**
```Gradle
implementation 'org.metabrainz.android:acousticbrainz:0.1.0'
```

# Usage
The `org.metabrainz.android.acousticbrainz` package exposes a single class, `AcousticBrainzClient`. `AcousticBrainzClient` autonmatically loads the necessary the native libraries. It exposes a static method `extractData(String, String)`.

```Java
AcousticBrainzClient.extractData(pathToInputAudioFile, pathToOutputJSONFile);
```

The `pathToInputAudioFile` argument takes the absolute path to the audio file to be analysed. Similarly, `pathToOutputJSONFile` takes the absolute path to the json file which should be created to store extracted data.     
It is difficult to obtain the absolute file path and usually an `InputStream` is available on Android devices. In that case, you should create a temporary file, write your `InputStream` to it and use the absolute path to this temporary file then. 
