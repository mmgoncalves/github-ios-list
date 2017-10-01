//
//  Date+Additions.swift
//  github-ios-list
//
//  Created by Mateus Marques on 01/10/17.
//  Copyright © 2017 Mateus Marques. All rights reserved.
//

import Foundation

extension Date {
    static func from(dateString: String) -> Date? {
        let formatt = DateFormatter()
        formatt.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatt.date(from: dateString)
    }
}
