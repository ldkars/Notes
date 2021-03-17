//
//  NotesListDispatcher.swift
//  CFTNotes
//
//  Created by Афанасий Корякин on 15.03.2021.
//

import Foundation
import Combine

final class NoteListDispatcher {
    static let shared = NoteListDispatcher()
    
    private let actionSubject = PassthroughSubject<NoteListAction, Never>()
    private var cancellables: [AnyCancellable] = []

    func register(callback: @escaping (NoteListAction) -> ()) {
        let actionStream = actionSubject.sink(receiveValue: callback)
        cancellables += [actionStream]
    }
    
    func dispatch(_ action: NoteListAction) {
        actionSubject.send(action)
    }
}
