//
//  APIService.swift
//  CFTNotes
//
//  Created by Афанасий Корякин on 15.03.2021.
//

import Foundation
import Combine

protocol APIRequestType {
    associatedtype Response: Decodable
    
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
}

protocol APIServiceType {
    func response<Request>(from request: Request) -> AnyPublisher<Request.Response, APIServiceError> where Request: APIRequestType
    
    //MARK: -- MockData
    func getNotes() -> AnyPublisher<NoteResponse, Never>
    func createNotes(newNote: Note) -> AnyPublisher<NoteResponse, Never>
    func deleteNotes(indexSet: IndexSet) -> AnyPublisher<NoteResponse, Never>
    func editNote(note: Note) -> AnyPublisher<NoteResponse, Never>
}

final class APIService: APIServiceType {
    
    private let baseURL: URL
    init(baseURL: URL = URL(string: "https://api.github.com")!) {
        self.baseURL = baseURL
    }
    
    //MARK:По факту не использую, но пусть лучше будет
    func response<Request>(from request: Request) -> AnyPublisher<Request.Response, APIServiceError> where Request: APIRequestType {
        let pathURL = URL(string: request.path, relativeTo: baseURL)!
        
        var urlComponents = URLComponents(url: pathURL, resolvingAgainstBaseURL: true)!
        urlComponents.queryItems = request.queryItems
        var request = URLRequest(url: urlComponents.url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let decorder = JSONDecoder()
        decorder.keyDecodingStrategy = .convertFromSnakeCase
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { data, urlResponse in data }
            .mapError { _ in APIServiceError.responseError }
            .decode(type: Request.Response.self, decoder: decorder)
            .mapError(APIServiceError.parseError)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func getNotes() -> AnyPublisher<NoteResponse, Never> {
        return DataBaseMock.notes.publisher.eraseToAnyPublisher()
    }
    
    func createNotes(newNote: Note) -> AnyPublisher<NoteResponse, Never> {
        DataBaseMock.notes[0].items.append(newNote)
        return DataBaseMock.notes.publisher.eraseToAnyPublisher()
    }
    
    func deleteNotes(indexSet: IndexSet) -> AnyPublisher<NoteResponse, Never> {
        DataBaseMock.notes[0].items.remove(atOffsets: indexSet)
        return DataBaseMock.notes.publisher.eraseToAnyPublisher()
    }
    
    func editNote(note: Note) -> AnyPublisher<NoteResponse, Never> {
        for i in 0..<DataBaseMock.notes[0].items.count {
            if DataBaseMock.notes[0].items[i].id == note.id{
                DataBaseMock.notes[0].items[i] = note
            }
        }
        return DataBaseMock.notes.publisher.eraseToAnyPublisher()
    }
}
