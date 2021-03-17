//
//  NotesLisAction.swift
//  CFTNotes
//
//  Created by Афанасий Корякин on 15.03.2021.
//

import Foundation

enum NoteListAction {
    case updateRepositories([Note])
    case updateErrorMessage(String)
    case showError
    case showIcon
}
