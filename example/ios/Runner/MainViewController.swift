//
//  MainViewController.swift
//  Runner
//
//  Created by gtbluesky on 2022/10/9.
//

import Foundation
import cooperation

class MainViewController: UIViewController {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!

    @IBAction func button1Click(_ sender: Any) {
        Cooperation.instance.call(method: "m1", arguments: ["platform": "iOS"], result: { (result) in
            if result is FlutterError {
                print("error: \(result)")
            } else if result as? NSObject == FlutterMethodNotImplemented {
                print("notImplemented: \(result)")
            } else {
                print(result)
            }
        })
    }

    @IBAction func button2Click(_ sender: Any) {
        Cooperation.instance.call(method: "m2", result: { (result) in
            if result is FlutterError {
                print("error: \(result)")
            } else if result as? NSObject == FlutterMethodNotImplemented {
                print("notImplemented: \(result)")
            } else {
                print(result)
            }
        })
    }
}
