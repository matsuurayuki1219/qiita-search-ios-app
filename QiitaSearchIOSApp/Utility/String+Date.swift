//
//  String+Date.swift
//  QiitaSearchIOSApp
//
//  Created by 松浦裕久 on 2023/10/14.
//

import Foundation

extension String {

    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        dateFormatter.locale = Locale.current
        let timezone = TimeZone.current
        dateFormatter.timeZone = timezone
        let date = dateFormatter.date(from: self)
        return date!
    }
}
