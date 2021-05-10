//
//  ContentView.swift
//  CFTNotes
//
//  Created by Афанасий Корякин on 15.03.2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var store: NoteListStore = .shared
    private let actionCreator: NoteListActionCreator
    
    init(actionCreator: NoteListActionCreator = .init()) {
        self.actionCreator = actionCreator
    }
    
    var body: some View {
        ZStack{
            if store.notes.isEmpty{
                emptyView
            }else{
                NavigationView{
                    ZStack{
                        List{
                            ForEach(store.notes){ note in
                                NoteListRow(note: note, actionCreator: actionCreator, index: store.notes.firstIndex(of: note)!)
                            }.onDelete { indexSet in
                                actionCreator.deleteNote(indexSet: indexSet)
                            }
                        }
                        .alert(isPresented: $store.isErrorShown) { () -> Alert in
                            Alert(title: Text("Error"), message: Text(store.errorMessage))
                        }
                        .navigationTitle(Text("Notes"))
                        
                        ButtonCreateNoteView()
                    }
                }.navigationViewStyle(StackNavigationViewStyle())
                
            }
        }.onAppear(perform: {
            self.actionCreator.onAppear()
        })
    }
}

var emptyView: some View{
    ZStack{
        Spacer()
        Text("Notes not created!")
            .font(.title)
            .foregroundColor(.black)
            .fontWeight(.heavy)
        ButtonCreateNoteView()
        Spacer()
    }
}
