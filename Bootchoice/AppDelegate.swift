//
//  AppDelegate.swift
//  Bootchoice
//
//  Created by C. Stott on 8/16/16.
//  Copyright © 2016 C. Stott. All rights reserved.
//

import Cocoa



@NSApplicationMain


    
class AppDelegate: NSObject, NSApplicationDelegate {
 
    func runCommand(_ cmd : String, args : String...) -> (output: [String], error: [String], exitCode: Int32) {
        
        let output : [String] = []
        let error : [String] = []
        
        let task = Process()
        task.launchPath = cmd
        task.arguments = args
        
        let outpipe = Pipe()
        task.standardOutput = outpipe
        let errpipe = Pipe()
        task.standardError = errpipe
        
        task.launch()

        
        task.waitUntilExit()
        let status = task.terminationStatus
        
        return (output, error, status)
    }
    
    func applicationWillFinishLaunching(_ notification: Notification) {
        
        let (output, error, status) = runCommand("/Applications/Utilities/Bootchoice.app/Contents/Resources/init.sh")
        print("program exited with status \(status)")
        let initstatus = (status)
        if initstatus == 1 {

            NSApplication.shared.terminate(self)
        }
        if output.count > 0 {
            print("program output:")
            print(output)
        }
        if error.count > 0 {

            NSApplication.shared.terminate(self)
        }
        

        
    }

    
    @IBOutlet var window: NSWindow!
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        let setscript = "/Applications/Utilities/Bootchoice.app/Contents/Resources/setvals.sh"
        
        let settask = Process()
        settask.launchPath = "/bin/bash"
        settask.arguments = ["-c", setscript]
        settask.launch()
        settask.waitUntilExit()
        

        window.makeKeyAndOrderFront(NSWindow.self)
        window.orderFrontRegardless()
        window.level = NSWindow.Level(rawValue: Int(CGWindowLevelForKey(.overlayWindow)))
        window.canBecomeVisibleWithoutLogin = true
        window.canHide = false

        NSApp.activate(ignoringOtherApps:true)
      
        if (self.window == nil){
            window.setIsVisible(true)
            window.update()
            window.display()
        }
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        self.window?.close()
        NSApplication.shared.terminate(self)
    }
    

    @IBAction func MacOS(_ sender: NSButton) {
        sender.isHighlighted = true
        self.window?.close()
        NSApplication.shared.terminate(self)

    }
    @IBAction func Windows(_ sender: NSButton) {
        
        let choicescript = "/Applications/Utilities/Bootchoice.app/Contents/Resources/bootchoice.sh"
        
        let choicetask = Process()
        choicetask.launchPath = "/bin/bash"
        choicetask.arguments = ["-c", choicescript]
        choicetask.launch()
    }
}

