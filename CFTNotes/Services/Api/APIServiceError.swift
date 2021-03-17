//
//  APIServiceError.swift
//  CFTNotes
//
//  Created by Афанасий Корякин on 15.03.2021.
//

import Foundation
enum APIServiceError: Error {
    case responseError
    case parseError(Error)
}
