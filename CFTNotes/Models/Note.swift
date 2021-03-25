//
//  Note.swift
//  CFTNotes
//
//  Created by Афанасий Корякин on 15.03.2021.
//

import Foundation
import SwiftUI

protocol NoteType : Decodable, Identifiable, Hashable {
    var id: UUID { get set }
    var title: String { get set }
    var description: String { get set }
}

struct Note: NoteType{
    var id = UUID()
    var title: String
    var description: String
}
