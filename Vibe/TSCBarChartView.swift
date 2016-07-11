//
//  TSCBarChartView.swift
//  Vibe
//
//  Created by Thomas Schoffelen on 18/06/2016.
//  Copyright © 2016 thomasschoffelen. All rights reserved.
//

import Cocoa

extension NSView {
    var backgroundColor: NSColor? {
        get {
            guard let layer = layer, backgroundColor = layer.backgroundColor else { return nil }
            return NSColor(CGColor: backgroundColor)
        }
        
        set {
            wantsLayer = true
            layer?.backgroundColor = newValue?.CGColor
        }
    }
}

class TSCBarChartView: NSView {
    
    private var barData : [String: Int]?
    private var barColor : NSColor?
    
    init(frame: CGRect, barData: [String: Int], barColor: NSColor) {
        super.init(frame: frame)
        
        self.barData = barData
        self.barColor = barColor
        self.renderBarData()
    }
    
    private func renderBarData(){
        if self.barData == nil {
            return
        }
        
        let barData = self.barData!
        
        var barOffset = 0
        var maxValue = 1
        var barCount = 0
        
        for (_, value) in barData {
            if value > 0 {
                barCount += 1
            }
            if value > maxValue {
                maxValue = value
            }
        }
        
        let barTop : CGFloat = 20
        let barHeight = frame.height - barTop
        let barWidth = frame.width / CGFloat(barCount) - 4.0
        
        let sortedKeys = Array(barData.keys).sort(<)
        Swift.print(sortedKeys)
        
        for var label in sortedKeys {
            let value = barData[label]!
            if value <= 0 {
                continue
            }
            while label.characters.contains("|") {
                label = String(label.characters.dropFirst())
            }
            
            let calculatedHeight = barHeight * (CGFloat(value) / CGFloat(maxValue))
            let calculatedFrame = CGRectMake(CGFloat(barOffset) * (barWidth + 4), barTop, barWidth, calculatedHeight)
            var valueLabelFrame = CGRectMake(CGFloat(barOffset) * (barWidth + 4), barTop, barWidth, calculatedHeight - 2)
            if(calculatedHeight < 18){
                valueLabelFrame = CGRectMake(CGFloat(barOffset) * (barWidth + 4), barTop, barWidth, calculatedHeight + 18) // Outside bar
            }
            
            let valueLabel = NSTextField(frame: valueLabelFrame)
            valueLabel.stringValue = String(value)
            valueLabel.bordered = false
            valueLabel.editable = false
            valueLabel.backgroundColor = NSColor(white: 1, alpha: 0)
            valueLabel.textColor = calculatedHeight >= 18 ? NSColor(white: 1, alpha: 0.7) : self.barColor
            valueLabel.alignment = .Center
            valueLabel.font = NSFont.systemFontOfSize(10)
            
            let labelLabel = NSTextField(frame: CGRectMake(CGFloat(barOffset) * (barWidth + 4) - 3, 0, barWidth + 6, barTop - 3))
            labelLabel.stringValue = String(label)
            labelLabel.bordered = false
            labelLabel.backgroundColor = NSColor(white: 1, alpha: 0)
            labelLabel.textColor = barColor
            labelLabel.alignment = .Center
            labelLabel.usesSingleLineMode = true
            labelLabel.editable = false
            labelLabel.font = NSFont.systemFontOfSize(11, weight: NSFontWeightSemibold)
            
            let barView = NSView(frame: calculatedFrame)
            barView.backgroundColor = self.barColor
            
            self.addSubview(barView)
            self.addSubview(valueLabel)
            self.addSubview(labelLabel)
            
            barOffset += 1
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
