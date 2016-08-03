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

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        self.window.titlebarAppearsTransparent = true
        self.window.isMovableByWindowBackground = true
        self.window.styleMask = NSFullSizeContentViewWindowMask
        self.window.backgroundColor = NSColor.white()
        
        self.window.makeKey()
        self.window.makeMain()
    
        self.updateStats()
        
        Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(AppDelegate.updateStats), userInfo: nil, repeats: true)
    }
    
    func updateStats() {
        DispatchQueue.global(attributes: DispatchQueue.GlobalAttributes.qosDefault).async {
            let stats = TSCStatsLoader.getStats();
            DispatchQueue.main.async {
                self.window.displayStats(stats);
            }
        }
    }

}

