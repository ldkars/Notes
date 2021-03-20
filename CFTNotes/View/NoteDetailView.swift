//
//  NoteDetailView.swift
//  CFTNotes
//
//  Created by Афанасий Корякин on 16.03.2021.
//

import Foundation
import SwiftUI

struct NoteDetailView: View {
    @ObservedObject var store: NoteListStore = .shared
    @State var showingModalEdit = false
    
    let note: Note
    let actionCreator: NoteListActionCreator
    let index: Int
    
    var body: some View {
        ZStack{
            ScrollView{
                VStack{
                    HStack{
                        Text(store.notes[index].title)
                            .font(.system(size: 60))
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                        Spacer()
                    }.padding()
                    Text(store.notes[index].description)
                    Spacer()
                }
            }.padding(.leading)
            
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Button {
                        showingModalEdit.toggle()
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
                    }.sheet(isPresented: $showingModalEdit) {
                        EditNoteModalView(title: store.notes[index].title, description: store.notes[index].description, note: note, actionCreater: actionCreator)
                    }
                }.padding(20)
            }
        }
    }
}


struct EditNoteModalView: View {
    
    @State var title: String
    @State var description: String
    
    let note: Note
    let actionCreater: NoteListActionCreator
    
    var body: some View {
        ZStack{
            VStack{
                TextField("Write your title!", text: $title).font(.system(size: 50))
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
            }
            ButtonEditNoteView(note: note, actionCreater: actionCreater, title: title, description: description)
        }
    }
}
