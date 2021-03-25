//
//  Folder.swift
//  CFTNotes
//
//  Created by Афанасий Корякин on 25.03.2021.
//

import Foundation

protocol FolderType: Decodable, Hashable, Identifiable{
    var id: UUID { get set }
    var name: String { get set }
    var folders: [Folder]? {get set}
    var notes: [Note]? { get set }
}

struct Folder: FolderType{    
    var id = UUID()
    var name: String
    var folders: [Folder]?
    var notes: [Note]?
}
