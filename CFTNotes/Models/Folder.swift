//
//  Folder.swift
//  CFTNotes
//
//  Created by Афанасий Корякин on 25.03.2021.
//

import Foundation

protocol FolderType /*Hashable : Decodable, Hashable, Identifiable*/{
   /* var id: UUID { get }
    var name: String { get set }
    var folders: [Folder]? {get set}
    var notes: [Note]? {get set}*/
    var name: String { get set }
    var id: UUID { get }
    var folders: [Folder]? {get set}
}

struct Folder: FolderType{    
    var id = UUID()
    var name: String
    var folders: [Folder]?
    var notes: [Note]?
}

struct PrivateFolder: FolderType{
    var id = UUID()
    var name: String
    var folders: [Folder]?
    var notes: [Note]?
}
