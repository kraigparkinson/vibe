//
//  TSCVibeWindow.swift
//  Vibe
//
//  Created by Thomas Schoffelen on 18/06/2016.
//  Copyright © 2016 thomasschoffelen. All rights reserved.
//

import Cocoa

typealias StatsDictionary = Dictionary<String,[String:Int]>

class TSCVibeWindow: NSWindow {

    @IBOutlet var weekGraph : NSView!;
    @IBOutlet var monthGraph : NSView!;
    @IBOutlet var weekdayGraph : NSView!;
    
    @IBOutlet var titleLabel : NSTextField?;
    @IBOutlet var subtitleLabel : NSTextField?;
    
    func displayStats(_ stats: StatsDictionary) {
        self.renderWeekGraph(stats);
        self.renderMonthGraph(stats);
        self.renderWeekdayGraph(stats);
        
        self.titleLabel?.stringValue = "\(stats["totals"]!["complete"]!) tasks completed."
        self.subtitleLabel?.stringValue = "\(stats["totals"]!["incomplete"]!) tasks are currently open."
    }
    
    internal func renderWeekGraph(_ stats: StatsDictionary) {
        let chartView = TSCBarChartView(frame: CGRect(x: 0,y: 0,width: self.weekGraph.frame.width, height: self.weekGraph.frame.height), barData: stats["days"]!, barColor: NSColor(red:0.60, green:0.55, blue:0.85, alpha:1.00));
        chartView.autoresizingMask = [.viewHeightSizable, .viewWidthSizable];
        chartView.translatesAutoresizingMaskIntoConstraints = true;
        
        self.weekGraph.addSubview(chartView);
    }
    
    internal func renderMonthGraph(_ stats: StatsDictionary) {
        let chartView = TSCBarChartView(frame: CGRect(x: 0,y: 0,width: self.monthGraph.frame.width, height: self.monthGraph.frame.height), barData: stats["months"]!, barColor: NSColor(red:0.36, green:0.65, blue:0.90, alpha:1.00));
        chartView.autoresizingMask = [.viewHeightSizable, .viewWidthSizable];
        chartView.translatesAutoresizingMaskIntoConstraints = true;
        
        self.monthGraph.addSubview(chartView);
    }
    
    internal func renderWeekdayGraph(_ stats: StatsDictionary) {
        let chartView = TSCBarChartView(frame: CGRect(x: 0,y: 0,width: self.weekdayGraph.frame.width, height: self.weekdayGraph.frame.height), barData: stats["weekdays"]!, barColor: NSColor(red:0.21, green:0.26, blue:0.33, alpha:1.00));
        chartView.autoresizingMask = [.viewHeightSizable, .viewWidthSizable];
        chartView.translatesAutoresizingMaskIntoConstraints = true;
        
        self.weekdayGraph.addSubview(chartView);
    }
    
}
