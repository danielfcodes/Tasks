//
//  DateFormatterExtensions.swift
//  SpendeeTask
//
//  Created by Daniel Fernandez on 10/22/19.
//  Copyright © 2019 danielfcodes. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    static let stringFormat = "dd/MM/yyyy HH:mm:ss"
    
    class func toDate(fromString string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = DateFormatter.stringFormat
        return dateFormatter.date(from: string)
    }
    
    class func toString(fromDate date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = DateFormatter.stringFormat
        return dateFormatter.string(from: date)
    }
    
}
