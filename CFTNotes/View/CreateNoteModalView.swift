//
//  CreateNoteModalView.swift
//  CFTNotes
//
//  Created by Афанасий Корякин on 17.03.2021.
//

import Foundation
import SwiftUI

struct CreateNoteModalView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var title: String = ""
    @State private var description: String = ""
    
    var actionCreater: NoteListActionCreator
    var body: some View {
        VStack{
            Spacer()
            TextField("Write your title!", text: $title).font(.system(size: 40))
            ZStack{
                TextEditor(text: $description)
                if description.isEmpty{
                    VStack{
                        HStack{
                            Text("Пишите, что хотите!")
                                .font(.system(size: 15))
                                .fontWeight(.heavy)
                                .foregroundColor(.gray)
                                .opacity(0.5)
                            Spacer()
                        }
                    }
                }
            }
            Spacer()
            Button {
                actionCreater.createNote(note: Note(id: UUID(), title: title, description: description))
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "plus")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(25)
                    .background(
                        AngularGradient(gradient: .init(colors: [.red]), center: .center)
                    )
                    .clipShape(Circle())
            }
        }
    }
}
