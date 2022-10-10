import UIKit
import cooperation

@UIApplicationMain
@objc class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
            _ application: UIApplication,
            didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let engineGroup = FlutterEngineGroup(name: "cooperation", project: nil)
        Cooperation.instance.install(engineGroup: engineGroup, library: "package:cooperation_example/entry.dart", entryPoint: "entry")
        window = UIWindow()
        window?.makeKeyAndVisible()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "MainVC")
        window?.rootViewController = initialViewController
        return true
    }
}
