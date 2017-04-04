//
//  AppDelegate.swift
//  StatusBar
//
//  Created by Taras Markevych on 02.04.17.
//  Copyright © 2017 Taras Markevych. All rights reserved.
//

import Cocoa

@NSApplicationMain

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem =  NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    let menu = NSMenu()
    var windowController : NSWindowController?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        initMenu()
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
   
    /*Initialize status bar menu  with buttons*/
    func initMenu(){
        if let button = statusItem.button {
            button.image = NSImage(named: "cleaner")
            button.action = #selector(cleadDerivedData)
        }
        menu.addItem(NSMenuItem(title: "Clean DerivedData", action: #selector(cleadDerivedData), keyEquivalent: "Y"))
        menu.addItem(NSMenuItem(title: "Preferences", action: #selector(openSettings) , keyEquivalent: ","))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: Selector("terminate:"), keyEquivalent: "q"))
        statusItem.menu = menu
    }
    
    func openSettings()  {

//        if let storyboard = NSStoryboard(name: "Main",bundle: nil) {
//            if let vc = storyboard.instantiateControllerWithIdentifier("settings") as? ViewController {
//                var myWindow = NSWindow(contentViewController: vc)
//                myWindow.makeKeyAndOrderFront(self)
//                let controller = NSWindowController(window: myWindow)
//                controller.showWindow(self)
//            }
//        }
        ViewController.view
        print("settings")
    }
    
    func cleadDerivedData() {
        let task = Process()
        task.launchPath = "/bin/sh"
        task.arguments = ["-c", "rm -rf ~/Library/Developer/Xcode/DerivedData/*"]
        task.launch()
        task.waitUntilExit()
        print("Deleted",task.arguments!)
    }

}

