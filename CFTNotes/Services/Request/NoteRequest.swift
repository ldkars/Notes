//
//  NoteRequest.swift
//  CFTNotes
//
//  Created by Афанасий Корякин on 15.03.2021.
//

import Foundation

struct NoteRequest: APIRequestType {
    typealias Response = NoteResponse
    
    var path: String { return "/search/repositories" }
    var queryItems: [URLQueryItem]? {
        return [
            .init(name: "q", value: "SwiftUI"),
            .init(name: "order", value: "desc")
        ]
    }
}
