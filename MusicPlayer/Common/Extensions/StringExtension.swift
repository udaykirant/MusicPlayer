//
//  StringExtension.swift
//  MusicPlayer
//
//  Created by Uday Kiran on 20/03/18.
//  Copyright © 2018 UK. All rights reserved.
//

import Foundation

extension String {
    func readableTimeFormat(forDuration duration: Float64) -> String {
        let timeInterval = Int(duration)
        let seconds = timeInterval % 60
        let minutes = (timeInterval / 60) % 60
        let hours = (timeInterval / (60 * 60))
        if hours > 0 {
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        }
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
