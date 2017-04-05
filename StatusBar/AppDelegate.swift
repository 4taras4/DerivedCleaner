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
    let defaults = UserDefaults.standard
    var statusItem =  NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    let menu = NSMenu()
    var windowController : NSWindowController?


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        initMenu()
        
        let defaultPath = "~/Library/Developer/Xcode/DerivedData/*"
        defaults.set(defaultPath, forKey: "path")
        defaults.synchronize()

    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
   
    /*Initialize status bar menu  with buttons*/
    func initMenu(){
        let mode = defaults.string(forKey: "AppleInterfaceStyle")
        if let button = statusItem.button {
            if defaults.string(forKey: "AppleInterfaceStyle") == "Dark" {
                button.image = NSImage(named: "darkIcon")
            } else {
                button.image = NSImage(named: "whiteIcon")
            }
            button.action = #selector(cleadDerivedData)
        }
        menu.addItem(NSMenuItem(title: "Clean DerivedData", action: #selector(cleadDerivedData), keyEquivalent: "Y"))
        menu.addItem(NSMenuItem(title: "Preferences", action: #selector(openSettings) , keyEquivalent: ","))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "About", action: #selector(openAbout), keyEquivalent: "A"))
        menu.addItem(NSMenuItem(title: "Quit", action: Selector("terminate:"), keyEquivalent: "q"))
        statusItem.menu = menu
    }
    
    func openSettings()  {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let wordCountWindowController = storyboard.instantiateController(withIdentifier: "Preference") as! NSWindowController
        let wordCountWindow = wordCountWindowController.window
        let application = NSApplication.shared()
            application.runModal(for: wordCountWindow!)
            print("settings")
    }
    
    func cleadDerivedData() {
        let dataPath = defaults.object(forKey: "path")
        print(dataPath!)
        let task = Process()
        task.launchPath = "/bin/sh"
        task.arguments = ["-c", "rm -rf \(dataPath!)"]
        task.launch()
        task.waitUntilExit()
        print("Deleted",task.arguments!)
    }
    
    func openAbout() {
        let url = URL(string: "https://github.com/4taras4/DerivedCleaner")
        NSWorkspace.shared().open(url!)
    }

}

