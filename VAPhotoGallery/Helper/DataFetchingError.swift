//
//  DataFetchingError.swift
//  VAManagerBuddy
//
//  Created by Vikash Anand on 22/02/20.
//  Copyright © 2020 Vikash Anand. All rights reserved.
//

import Foundation

enum DataFetchingError: Error {
    case unknown
    case noInternet
    case badResponse
    case noRecords
}

extension DataFetchingError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .unknown:
            return NSLocalizedString("Something went wrong. Please try again later.", comment: "Error")
        case .badResponse:
            return NSLocalizedString("Response is not in appropriate format.", comment: "Bad Response")
        case .noInternet:
            return NSLocalizedString("Please check your internet connetion.", comment: "No Internet")
        case .noRecords:
            return NSLocalizedString("No records to show.", comment: "No Records")
        }
    }
}
