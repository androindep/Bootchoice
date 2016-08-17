//
//  AppDelegate.swift
//  Bootchoice
//
//  Created by Stott, Cameron on 8/16/16.
//  Copyright © 2016 Stott, Cameron. All rights reserved.
//

import Cocoa


@NSApplicationMain

class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet var window: NSWindow!
    
    func orderFrontRegardless(){}
    func makeMainWindow(){}
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application

        window.level = Int(CGWindowLevelForKey(.MainMenuWindowLevelKey))
        window.canBecomeVisibleWithoutLogin = true
        window.canHide = false
        func orderFrontRegardless(){}
        func makeMainWindow(){}
    }
    
    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
        
    }

    @IBAction func MacOS(sender: NSButton) {
        self.window?.close()
        NSApplication.sharedApplication().terminate(self)

    }
    @IBAction func Windows(sender: NSButton) {
        let script = "/Applications/Utilities/Bootchoice.app/Contents/Resources/bootchoice.sh"
        
        let task = NSTask()
        task.launchPath = "/bin/bash"
        task.arguments = ["-c", script]
        task.launch()
    }
}

