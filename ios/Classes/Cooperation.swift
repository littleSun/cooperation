//
// Created by gtbluesky on 2022/10/9.
//

import Foundation

public class Cooperation: NSObject {
    @objc public static let instance = Cooperation()
    private var engine: FlutterEngine? = nil
    private var methodChannel: FlutterMethodChannel? = nil

    private override init() {
        super.init()
    }

    @objc public func install(_ engine: FlutterEngine) {
        self.engine = engine
        methodChannel = FlutterMethodChannel(name: "cooperation_channel", binaryMessenger: engine.binaryMessenger)
    }

    @objc public func install(
            engineGroup: FlutterEngineGroup,
            library: String? = nil,
            entryPoint: String? = nil
    ) {
        let engine = engineGroup.makeEngine(withEntrypoint: entryPoint, libraryURI: library)
        install(engine)
        let clazz = NSClassFromString("GeneratedPluginRegistrant") as? NSObject.Type
        let selector = NSSelectorFromString("registerWithRegistry:")
        if clazz?.responds(to: selector) == true {
            clazz?.perform(selector, with: engine)
        }
    }

    @objc public func uninstall() {
        methodChannel = nil
        engine?.destroyContext()
        engine = nil
    }

    @objc public func call(
            method: String,
            arguments: Dictionary<String, Any>? = nil,
            result: FlutterResult? = nil
    ) {
        methodChannel?.invokeMethod(method, arguments: arguments, result: result)
    }
}