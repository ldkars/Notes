//
//  NotesListActionCreator.swift
//  CFTNotes
//
//  Created by Афанасий Корякин on 15.03.2021.
//

import Foundation
import Combine

final class NoteListActionCreator {
    private let dispatcher: NoteListDispatcher
    private let apiService: APIServiceType
    
    private let onAppearSubject = PassthroughSubject<Void, Never>()
    private let createNoteSubject = PassthroughSubject<Note, Never>()
    private let deleteNoteSubject = PassthroughSubject<IndexSet, Never>()
    private let editNoteSubject = PassthroughSubject<Note, Never>()
    
    private let responseSubject = PassthroughSubject<NoteResponse, Never>()
    
    private let errorSubject = PassthroughSubject<APIServiceError, Never>()
    private var cancellables: [AnyCancellable] = []

    init(dispatcher: NoteListDispatcher = .shared,
         apiService: APIServiceType = APIService()) {
        self.dispatcher = dispatcher
        self.apiService = apiService

        bindData()
        bindActions()
    }
    
    func bindData() {
        let responsePublisher = onAppearSubject
            .flatMap { [apiService] _ in apiService.response()}
        
        let responseStream = responsePublisher
            .share()
            .subscribe(responseSubject)
        
        
        let responseCreateNotePublisher = createNoteSubject
            .flatMap { (Note) -> AnyPublisher<NoteResponse, Never> in
                self.apiService.createNotes(newNote: Note)
            }
        
        let responseCreateNoteStream = responseCreateNotePublisher
            .share()
            .subscribe(responseSubject)
        
        
        let responseDeleteNotePublisher = deleteNoteSubject
            .flatMap { (indexSet) -> AnyPublisher<NoteResponse, Never> in
                self.apiService.deleteNotes(indexSet: indexSet)
            }
        
        let responseDeleteNoteStream = responseDeleteNotePublisher
            .share()
            .subscribe(responseSubject)
        
        let responseEditNotePublisher = editNoteSubject
            .flatMap { (note) -> AnyPublisher<NoteResponse, Never> in
                self.apiService.editNote(note: note)
            }
    
        let responseEditNoteStream = responseEditNotePublisher
            .share()
            .subscribe(responseSubject)
        
        cancellables += [
            responseStream,
            responseCreateNoteStream,
            responseDeleteNoteStream,
            responseEditNoteStream
        ]
    }
    
    func bindActions() {
        let responseDataStream = responseSubject
            .map { $0.items }
            .sink(receiveValue: { [dispatcher] in dispatcher.dispatch(.updateRepositories($0)) })
        
        let errorStream = errorSubject
            .map { _ in }
            .sink(receiveValue: { [dispatcher] in dispatcher.dispatch(.showError) })
            
        cancellables += [
            responseDataStream,
            errorStream
        ]
    }
    
    func onAppear() {
        onAppearSubject.send(())
    }
    
    func createNote(note: Note){
        createNoteSubject.send(note)
    }
    
    func deleteNote(indexSet: IndexSet){
        deleteNoteSubject.send(indexSet)
    }
    
    func editNote(note: Note){
        editNoteSubject.send(note)
    }
}
