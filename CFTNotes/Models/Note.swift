//
//  Note.swift
//  CFTNotes
//
//  Created by Афанасий Корякин on 15.03.2021.
//

import Foundation
import SwiftUI

struct NoteStyle {
    var titleColor: Color?
    var descriptionColor: Color?
}

protocol NoteType : Decodable, Hashable, Identifiable {
    var title: String { get set }
    var description: String { get set }
}

struct Note: NoteType {
    var id = UUID()
    var title: String
    var description: String
}
