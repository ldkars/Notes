//
//  NoteResponce.swift
//  CFTNotes
//
//  Created by Афанасий Корякин on 15.03.2021.
//

import Foundation

struct NoteResponse: Decodable {
    var items: [Note]
}
