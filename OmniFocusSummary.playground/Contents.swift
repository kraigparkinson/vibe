//: Playground - noun: a place where people can play

import Cocoa

let myAppleScript = "set theProgressDetail to \"\"\ntell application \"OmniFocus\"\ntell front document\nset theModifiedProjects to every flattened project\nrepeat with a from 1 to length of theModifiedProjects\nset theCompletedTasks to (every flattened task of (item a of theModifiedProjects) where its number of tasks = 0)\nif theCompletedTasks is not equal to {} then\nrepeat with b from 1 to length of theCompletedTasks\nset theProgressDetail to theProgressDetail & completion date of (item b of theCompletedTasks) & return\nend repeat\nend if\nend repeat\nset theInboxCompletedTasks to (every inbox task where its number of tasks = 0)\nrepeat with d from 1 to length of theInboxCompletedTasks\nset theProgressDetail to theProgressDetail & completion date of (item d of theInboxCompletedTasks) & return\nend repeat\nend tell\nend tell\nreturn theProgressDetail"
var error: NSDictionary?
if let scriptObject = NSAppleScript(source: myAppleScript) {
    if let output: NSAppleEventDescriptor = scriptObject.executeAndReturnError(
        &error) {
        let dates = output.stringValue!.componentsSeparatedByString("\r");
        var countsDays:[String:Int] = [:]
        var countsWeeks:[String:Int] = [:]
        var countsMonths:[String:Int] = [:]
        
        var countsDayOfWeek:[String:Int] = [:]
        
        var countIncomplete = 0;
        var countComplete = 0;
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale.currentLocale()
        dateFormatter.dateStyle = .FullStyle
        dateFormatter.timeStyle = .MediumStyle
        
        let calendar = NSCalendar.currentCalendar()
        
        let now = calendar.components([.WeekOfYear, .Day, .Month, .Year], fromDate: NSDate())
        let nowTime = NSDate().timeIntervalSince1970;
        
        for item in dates {
            if item == "missing value" {
                countIncomplete += 1;
                continue;
            }
            
            if let date = dateFormatter.dateFromString(item) {
                countComplete += 1;
                
                let then = calendar.components([.WeekOfYear, .Weekday, .Day, .Month, .Year], fromDate: date)
                let thenTime = date.timeIntervalSince1970;
            
                if then.year == now.year {
                    let weekName = "Week \(then.weekOfYear)"
                    countsWeeks[weekName] = (countsWeeks[weekName] ?? 0) + 1
                    
                    let monthName = "\(then.month)"
                    countsMonths[monthName] = (countsMonths[monthName] ?? 0) + 1
                }
                
                if thenTime >= nowTime - 7 * 86400 {
                    let dayName = "\(then.day)-\(then.month)"
                    countsDays[dayName] = (countsDays[dayName] ?? 0) + 1
                }
                
                let dayOfWeekName = "\(then.weekday)"
                countsDayOfWeek[dayOfWeekName] = (countsDayOfWeek[dayOfWeekName] ?? 0) + 1
            }else{
                print("Failed to parse: \(item)")
            }
        }
    
        print(countsDays)
        print(countsWeeks)
        print(countsMonths)
        print(countsDayOfWeek)
        print("\(countIncomplete) incomplete, \(countComplete) completed")
    } else if (error != nil) {
        print("error: \(error)")
    }
}
    
