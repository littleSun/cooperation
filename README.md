# Cooperation

## 简介

在日常开发中，一些端上复杂的业务逻辑需要在 Android 和 iOS 上各自实现一遍，这既浪费了开发资源，也极可能在细节处理上存在差异，导致在边界条件下出现不同效果。`Cooperation` 可以帮助开发者使用 Dart 编写逻辑，在不渲染 UI 的情况下即可在 Native 中直接调用，借助 Dart 和 Flutter 生态快速实现业务需求。

## 开始使用

### 0、准备

在开始前需要按照 [Flutter 官方文档](https://docs.flutter.dev/development/add-to-app)，创建一个 Flutter Module 项目，并将其接入到 Android 和 iOS 工程中。

### 1、初始化

Flutter 侧

入口建议和 UI 的默认入口（即main函数）分开，也可写在其他dart文件中。

如果我们想在其他项目中也可以使用已实现的逻辑，则可以创建一个 Flutter Plugin 项目并将逻辑写在里面，这样只要 Flutter Module 依赖该 Flutter Plugin 即可实现代码复用。

```dart
import 'package:cooperation/cooperation.dart';

@pragma('vm:entry-point')
entry() {
  Cooperation.instance.addHandler('m1', (arguments) async {
    return arguments?['platform'];
  });
}
```

Android 侧

初始化

```kotlin
class MyApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        ...
      	// 传入已创建好的flutterEngine
        Cooperation.install(engine)
      	// 或者传入enginegroup，可根据需要设置入口函数，默认入口为main
        Cooperation.install(this, engineGroup, entryPoint = "entry")
    }
}
```

调用

```kotlin
Cooperation.call("m1", mapOf("platform" to "Android"), object : MethodChannel.Result {
                override fun success(result: Any?) {
                    Toast.makeText(this@MainActivity, "success:$result", Toast.LENGTH_SHORT).show()
                }

                override fun error(errorCode: String?, errorMessage: String?, errorDetails: Any?) {
                    Toast.makeText(this@MainActivity, "error:$errorCode", Toast.LENGTH_SHORT).show()
                }

                override fun notImplemented() {
                    Toast.makeText(this@MainActivity, "notImplemented", Toast.LENGTH_SHORT).show()
                }
            })
```



iOS侧

初始化

```swift
// 传入已创建好的flutterEngine
Cooperation.instance.install(engine)
// 或者传入enginegroup，可根据需要设置入口函数，默认入口为main
Cooperation.instance.install(engineGroup: engineGroup, entryPoint: "entry")
```

调用

```swift
Cooperation.instance.call(method: "m1", arguments: ["platform": "iOS"], result: { (result) in
            if result is FlutterError {
                print("error: \(result)")
            } else if result as? NSObject == FlutterMethodNotImplemented {
                print("notImplemented: \(result)")
            } else {
                print(result)
            }
        })
```
