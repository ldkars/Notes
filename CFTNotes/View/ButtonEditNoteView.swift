//
//  ButtonEditNote.swift
//  CFTNotes
//
//  Created by Афанасий Корякин on 17.03.2021.
//

import Foundation
import SwiftUI

struct ButtonEditNoteView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    let note: Note
    let actionCreater: NoteListActionCreator
    
    var title: String
    var description: String
    
    var body: some View {
        VStack{
            Spacer()
            HStack{
                Spacer()
                Button {
                    actionCreater.editNote(note: Note(id: note.id, title: title, description: description))
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack{
                        Image(systemName: "pencil")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .padding(20)
                            .background(
                                AngularGradient(gradient: .init(colors: [.red]), center: .center)
                            )
                            .clipShape(Circle())
                    }
                }.ignoresSafeArea(.all)
            }.padding(20)
        }
    }
}
