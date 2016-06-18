//
//  AppDelegate.swift
//  Vibe
//
//  Created by Thomas Schoffelen on 18/06/2016.
//  Copyright © 2016 thomasschoffelen. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: TSCVibeWindow!

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        self.window.titlebarAppearsTransparent = true
        self.window.movableByWindowBackground = true
        self.window.styleMask |= NSFullSizeContentViewWindowMask
        self.window.backgroundColor = NSColor.whiteColor()
        
        self.window.makeKeyWindow()
        self.window.makeMainWindow()
    
        self.updateStats()
        
        NSTimer.scheduledTimerWithTimeInterval(30, target: self, selector: #selector(AppDelegate.updateStats), userInfo: nil, repeats: true)
    }
    
    func updateStats() {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let stats = TSCStatsLoader.getStats();
            dispatch_async(dispatch_get_main_queue()) {
                self.window.displayStats(stats);
            }
        }
    }

}

