# qr_test_step3

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## App Release 권한관리

`출처`
- [[Flutter] 앱 권한 관리하기(permission_handler)](https://velog.io/@error/Flutter-%EC%95%B1-%EA%B6%8C%ED%99%98-%EA%B4%80%EB%A6%AC%ED%95%98%EA%B8%B0)
### 패키지 설치

```yaml
dependencies:
  permission_handler: ^10.0.0
```

### build.gradle 설정

```bash
flutter project/android/app/build.gradle
```

#### 변경할 라인
- `compileSdkVersion 33`
- `minSdkVersion 20`

```
android {
    namespace "com.example.qr_test_step3"
    compileSdkVersion 33
    ndkVersion flutter.ndkVersion

    compileOptions {
        sourceCompatibility JavaVersion.VERSION_1_8
        targetCompatibility JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = '1.8'
    }

    sourceSets {
        main.java.srcDirs += 'src/main/kotlin'
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId "com.example.qr_test_step3"
        // You can update the following values to match your application needs.
        // For more information, see: https://docs.flutter.dev/deployment/android#reviewing-the-gradle-build-configuration.
        minSdkVersion 20
        targetSdkVersion flutter.targetSdkVersion
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName
    }
```

### Android 권한관리
`AndroidManifest.xml`

```bash
# 파일 
$ flutter project/android/app/src/main/AndroidManifest.xml
```

#### 권한 관련 삽입 문구

```xml
<!--
    Internet permissions do not affect the `permission_handler` plugin, but are required if your app needs access to
    the internet.
    디버그 모드에서는 INTERNET 권한이 없어도 API 요청 등이 동작한다. 릴리즈 모드에서 사용하기 위해서는 해당 권한이 필요하다.
    -->
    <uses-permission android:name="android.permission.INTERNET"/>

    <!-- Permissions options for the `contacts` group 
	* 그룹 권한의 경우
	<uses-permission android:name="android.permission-group.CONTACTS"/>
	와 같이 한번에 권한 사용을 지정할 수 있다.
	-->
    <uses-permission android:name="android.permission.READ_CONTACTS"/>
    <uses-permission android:name="android.permission.WRITE_CONTACTS"/>
    <uses-permission android:name="android.permission.GET_ACCOUNTS"/>

    <!-- Permissions options for the `storage` group -->
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>

    <!-- Permissions options for the `camera` group -->
    <uses-permission android:name="android.permission.CAMERA"/>

    <!-- Permissions options for the `sms` group -->
    <uses-permission android:name="android.permission.SEND_SMS"/>
    <uses-permission android:name="android.permission.RECEIVE_SMS"/>
    <uses-permission android:name="android.permission.READ_SMS"/>
    <uses-permission android:name="android.permission.RECEIVE_WAP_PUSH"/>
    <uses-permission android:name="android.permission.RECEIVE_MMS"/>

    <!-- Permissions options for the `phone` group -->
    <uses-permission android:name="android.permission.READ_PHONE_STATE"/>
    <uses-permission android:name="android.permission.CALL_PHONE"/>
    <uses-permission android:name="android.permission.ADD_VOICEMAIL"/>
    <uses-permission android:name="android.permission.USE_SIP"/>
    <uses-permission android:name="android.permission.READ_CALL_LOG"/>
    <uses-permission android:name="android.permission.WRITE_CALL_LOG"/>
    <uses-permission android:name="android.permission.BIND_CALL_REDIRECTION_SERVICE"/>

    <!-- Permissions options for the `calendar` group -->
    <uses-permission android:name="android.permission.READ_CALENDAR" />
    <uses-permission android:name="android.permission.WRITE_CALENDAR" />

    <!-- Permissions options for the `location` group -->
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION" />

    <!-- Permissions options for the `microphone` or `speech` group -->
    <uses-permission android:name="android.permission.RECORD_AUDIO" />

    <!-- Permissions options for the `sensors` group -->
    <uses-permission android:name="android.permission.BODY_SENSORS" />

    <!-- Permissions options for the `accessMediaLocation` group -->
    <uses-permission android:name="android.permission.ACCESS_MEDIA_LOCATION" />

    <!-- Permissions options for the `activityRecognition` group -->
    <uses-permission android:name="android.permission.ACTIVITY_RECOGNITION" />

    <!-- Permissions options for the `ignoreBatteryOptimizations` group -->
    <uses-permission android:name="android.permission.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS" />

    <!-- Permissions options for the `bluetooth` group -->
    <uses-permission android:name="android.permission.BLUETOOTH" />
    <uses-permission android:name="android.permission.BLUETOOTH_SCAN" />
    <uses-permission android:name="android.permission.BLUETOOTH_ADVERTISE" />
    <uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />

    <!-- Permissions options for the `manage external storage` group -->
    <uses-permission android:name="android.permission.MANAGE_EXTERNAL_STORAGE" />

    <!-- Permissions options for the `system alert windows` group -->
    <uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />

    <!-- Permissions options for the `request install packages` group -->
    <uses-permission android:name="android.permission.REQUEST_INSTALL_PACKAGES" />

    <!-- Permissions options for the `access notification policy` group -->
    <uses-permission android:name="android.permission.ACCESS_NOTIFICATION_POLICY"/>

    <application
    ...
```

### IOS 권한관리

대산 파일 `info.plist`, `Podfile`

#### `info.plist`

```
<dict>
	...

<!-- Permission options for the `location` group -->
    <key>NSLocationWhenInUseUsageDescription</key>
    <string>Need location when in use</string>
    <key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
    <string>Always and when in use!</string>
    <key>NSLocationUsageDescription</key>
    <string>Older devices need location.</string>
    <key>NSLocationAlwaysUsageDescription</key>
    <string>Can I have location always?</string>

    <!-- Permission options for the `mediaLibrary` group -->
    <key>NSAppleMusicUsageDescription</key>
    <string>Music!</string>
    <key>kTCCServiceMediaLibrary</key>
    <string>media</string>

    <!-- Permission options for the `calendar` group -->
    <key>NSCalendarsUsageDescription</key>
    <string>Calendars</string>

    <!-- Permission options for the `camera` group -->
    <key>NSCameraUsageDescription</key>
    <string>camera</string>

    <!-- Permission options for the `contacts` group -->
    <key>NSContactsUsageDescription</key>
    <string>contacts</string>

    <!-- Permission options for the `microphone` group -->
    <key>NSMicrophoneUsageDescription</key>
    <string>microphone</string>

    <!-- Permission options for the `speech` group -->
    <key>NSSpeechRecognitionUsageDescription</key>
    <string>speech</string>

    <!-- Permission options for the `sensors` group -->
    <key>NSMotionUsageDescription</key>
    <string>motion</string>

    <!-- Permission options for the `photos` group -->
    <key>NSPhotoLibraryUsageDescription</key>
    <string>photos</string>

    <!-- Permission options for the `reminder` group -->
    <key>NSRemindersUsageDescription</key>
    <string>reminders</string>

    <!-- Permission options for the `bluetooth` -->
    <key>NSBluetoothAlwaysUsageDescription</key>
    <string>bluetooth</string>
    <key>NSBluetoothPeripheralUsageDescription</key>
    <string>bluetooth</string>

    <!-- Permission options for the `appTrackingTransparency` -->
    <key>NSUserTrackingUsageDescription</key>
    <string>appTrackingTransparency</string>
</dict>
```

#### `Podfile`

```Podfile
post_install do |installer|
  installer.pods_project.targets.each do |target|
    ... # Here are some configurations automatically generated by flutter

    # Start of the permission_handler configuration
    target.build_configurations.each do |config|

      # You can enable the permissions needed here. For example to enable camera
      # permission, just remove the `#` character in front so it looks like this:
      #
      # ## dart: PermissionGroup.camera
      # 'PERMISSION_CAMERA=1'
      #
      #  Preprocessor definitions can be found in: https://github.com/Baseflow/flutter-permission-handler/blob/master/permission_handler_apple/ios/Classes/PermissionHandlerEnums.h
      config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= [
        '$(inherited)',

        ## dart: PermissionGroup.calendar
        # 'PERMISSION_EVENTS=1',

        ## dart: PermissionGroup.reminders
        # 'PERMISSION_REMINDERS=1',

        ## dart: PermissionGroup.contacts
        # 'PERMISSION_CONTACTS=1',

        ## dart: PermissionGroup.camera
        # 'PERMISSION_CAMERA=1',

        ## dart: PermissionGroup.microphone
        # 'PERMISSION_MICROPHONE=1',

        ## dart: PermissionGroup.speech
        # 'PERMISSION_SPEECH_RECOGNIZER=1',

        ## dart: PermissionGroup.photos
        # 'PERMISSION_PHOTOS=1',

        ## dart: [PermissionGroup.location, PermissionGroup.locationAlways, PermissionGroup.locationWhenInUse]
        # 'PERMISSION_LOCATION=1',

        ## dart: PermissionGroup.notification
        # 'PERMISSION_NOTIFICATIONS=1',

        ## dart: PermissionGroup.mediaLibrary
        # 'PERMISSION_MEDIA_LIBRARY=1',

        ## dart: PermissionGroup.sensors
        # 'PERMISSION_SENSORS=1',   

        ## dart: PermissionGroup.bluetooth
        # 'PERMISSION_BLUETOOTH=1',

        ## dart: PermissionGroup.appTrackingTransparency
        # 'PERMISSION_APP_TRACKING_TRANSPARENCY=1',

        ## dart: PermissionGroup.criticalAlerts
        # 'PERMISSION_CRITICAL_ALERTS=1'
      ]

    end 
    # End of the permission_handler configuration
  end
end
```


