//
//  ViewController.swift
//  StatusBar
//
//  Created by Taras Markevych on 02.04.17.
//  Copyright © 2017 Taras Markevych. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    let defaults = UserDefaults.standard
    @IBAction func saveAction(_ sender: Any) {
        let defaultPath = pathTextField.stringValue
        defaults.set(defaultPath, forKey: "path")
        defaults.synchronize()
        let application = NSApplication.shared()
        application.stopModal()
    }
    
    @IBAction func defaultAction(_ sender: Any) {
        let defaultPath = "~/Library/Developer/Xcode/DerivedData/*"
        pathTextField.stringValue = defaultPath
        defaults.set(defaultPath, forKey: "path")
        defaults.synchronize()
    }
    
    @IBOutlet weak var pathTextField: NSTextField!
    
    var pathToFolder:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

