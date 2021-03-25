//
//  NotesListStore.swift
//  CFTNotes
//
//  Created by Афанасий Корякин on 15.03.2021.
//

import Foundation
import Combine
import SwiftUI

final class NoteListStore: ObservableObject {
    static let shared = NoteListStore()
    
    @Published private(set) var notes: [Note] = []
    @Published private(set) var folders: [FolderType] = []
    @Published var isErrorShown = false
    @Published var errorMessage = ""
    @Published private(set) var shouldShowIcon = false
    
    init(dispatcher: NoteListDispatcher = .shared) {
        dispatcher.register { [weak self] (action) in
            guard let strongSelf = self else { return }
            
            switch action {
                case .updateRepositories(let notes): strongSelf.notes = notes
                case .updateErrorMessage(let message): strongSelf.errorMessage = message
                case .showError: strongSelf.isErrorShown = true
                case .showIcon: break
            }
        }
    }
}
