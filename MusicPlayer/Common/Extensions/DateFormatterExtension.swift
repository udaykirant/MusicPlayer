//
//  DateFormatterExtension.swift
//  MusicPlayer
//
//  Created by Uday Kiran on 15/03/18.
//  Copyright © 2018 UK. All rights reserved.
//

import Foundation

extension DateFormatter {
    static let serverFormate: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier :"en_US_POSIX")
        dateFormatter.dateFormat = Constants.serverDateFormate
        return dateFormatter
    }()
}
