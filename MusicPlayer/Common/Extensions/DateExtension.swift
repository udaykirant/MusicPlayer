//
//  DateExtension.swift
//  MusicPlayer
//
//  Created by Uday Kiran on 21/03/18.
//  Copyright © 2018 UK. All rights reserved.
//

import Foundation

extension Date {
    func differenceWithCurrentDate() -> String {
         let difference = Calendar.current.dateComponents([.second, .minute, .hour, .day, .month, .year], from: self, to: Date())
        if let years = difference.year, years > 1 { return String(years) + " years ago" }
        if let years = difference.year, years == 1 { return String(years) + " year ago" }
        if let months = difference.month, months > 1 { return String(months) + " months ago" }
        if let months = difference.month, months == 1 { return String(months) + " month ago" }
        if let days = difference.day, days > 1 { return String(days) + " days ago" }
        if let days = difference.day, days == 1 { return String(days) + " day ago" }
        if let hours = difference.hour, hours > 1 { return String(hours) + " hours ago" }
        if let hours = difference.hour, hours == 1 { return String(hours) + " hour ago" }
        if let minutes = difference.minute, minutes > 1 { return String(minutes) + " mins ago" }
        if let minutes = difference.minute, minutes == 1 { return String(minutes) + " min ago" }
        if let seconds = difference.second, seconds > 0 { return String(seconds) + " sec ago" }
        
        return ""
    }
}
