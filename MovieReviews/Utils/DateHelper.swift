//
//  DateHelper.swift
//  MovieReviews
//
//  Created by Viktor Rezvantsev on 25.07.2020.
//  Copyright © 2020 Viktor Rezvantsev. All rights reserved.
//

import Foundation

class DateHelper {
    
    static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone.ReferenceType.local
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        return formatter
    }()
    
}
