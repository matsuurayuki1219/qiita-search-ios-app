//
//  ApiError.swift
//  QiitaSearchIOSApp
//
//  Created by 松浦裕久 on 2023/10/14.
//

import Foundation

enum ApiError : Error {
    case invalidUrl
    case responseError
    case decodeError
    case unknown
}
