//
//  Date+String.swift
//  QiitaSearchIOSApp
//
//  Created by 松浦裕久 on 2023/10/14.
//

import Foundation

extension Date {

    func toAppString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = NSLocalizedString("common.date_format", comment: "")
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        let str = dateFormatter.string(from: self)
        return str
    }
}
