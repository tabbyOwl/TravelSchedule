//
//  Error+Ext.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/5/15.
//

import OpenAPIRuntime
import Foundation

extension Error {

    var asErrorMode: ErrorMode {

        guard
            let clientError = self as? ClientError,
            let urlError = clientError.underlyingError as? URLError
        else {
            return .serverError
        }

        switch urlError.code {

        case .notConnectedToInternet,
             .networkConnectionLost:
            return .noInternet

        default:
            return .serverError
        }
    }
}
