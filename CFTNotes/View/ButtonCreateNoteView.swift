//
//  ButtonCreateNoteView.swift
//  CFTNotes
//
//  Created by Афанасий Корякин on 17.03.2021.
//

import Foundation
import SwiftUI

struct ButtonCreateNoteView: View {
    
    @State var showingModalCreate = false
    let actionCreater: NoteListActionCreator
    
    var body: some View {
        VStack{
            Spacer()
            HStack{
                Spacer()
                Button {
                    showingModalCreate.toggle()
                } label: {
                    Image(systemName: "plus")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(25)
                        .background(
                            AngularGradient(gradient: .init(colors: [.red]), center: .center)
                        )
                        .clipShape(Circle())
                }.sheet(isPresented: $showingModalCreate) {
                    CreateNoteModalView(actionCreater: actionCreater)
                }
            }.padding(20)
        }
    }
}
