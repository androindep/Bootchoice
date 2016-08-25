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
 
    func runCommand(cmd : String, args : String...) -> (output: [String], error: [String], exitCode: Int32) {
        
        var output : [String] = []
        var error : [String] = []
        
        let task = NSTask()
        task.launchPath = cmd
        task.arguments = args
        
        let outpipe = NSPipe()
        task.standardOutput = outpipe
        let errpipe = NSPipe()
        task.standardError = errpipe
        
        task.launch()
        
        let outdata = outpipe.fileHandleForReading.readDataToEndOfFile()
        if var string = String.fromCString(UnsafePointer(outdata.bytes)) {
            string = string.stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet())
            output = string.componentsSeparatedByString("\n")
        }
        
        let errdata = errpipe.fileHandleForReading.readDataToEndOfFile()
        if var string = String.fromCString(UnsafePointer(errdata.bytes)) {
            string = string.stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet())
            error = string.componentsSeparatedByString("\n")
        }
        
        task.waitUntilExit()
        let status = task.terminationStatus
        
        return (output, error, status)
    }
    
    func applicationWillFinishLaunching(notification: NSNotification) {
        
        let (output, error, status) = runCommand("/Applications/Utilities/Bootchoice.app/Contents/Resources/init.sh")
        print("program exited with status \(status)")
        let initstatus = (status)
        if initstatus == 1 {

            NSApplication.sharedApplication().terminate(self)
        }
        if output.count > 0 {
            print("program output:")
            print(output)
        }
        if error.count > 0 {

            NSApplication.sharedApplication().terminate(self)
        }
        

        
    }

    
    @IBOutlet var window: NSWindow!
    
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        
        let setscript = "/Applications/Utilities/Bootchoice.app/Contents/Resources/setvals.sh"
        
        let settask = NSTask()
        settask.launchPath = "/bin/bash"
        settask.arguments = ["-c", setscript]
        settask.launch()
        settask.waitUntilExit()
        
        window.makeKeyAndOrderFront(NSWindow)
        window.orderFrontRegardless()
        window.level = Int(CGWindowLevelForKey(.MainMenuWindowLevelKey))
        window.canBecomeVisibleWithoutLogin = true
        window.canHide = false

    }
    
    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
        
    }
    

    @IBAction func MacOS(sender: NSButton) {
        sender.highlighted = true
        self.window?.close()
        NSApplication.sharedApplication().terminate(self)

    }
    @IBAction func Windows(sender: NSButton) {
        
        let choicescript = "/Applications/Utilities/Bootchoice.app/Contents/Resources/bootchoice.sh"
        
        let choicetask = NSTask()
        choicetask.launchPath = "/bin/bash"
        choicetask.arguments = ["-c", choicescript]
        choicetask.launch()
    }
}

