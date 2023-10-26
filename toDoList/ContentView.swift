//
//  ContentView.swift
//  toDoList
//
//  Created by Edward Mayk on 24/10/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var descriptionNote: String = ""
    @StateObject var notesViewModel = NoteViewModel()
    
    var body: some View {
        NavigationView{
            VStack{
                Text("Añade una tarea")
                    .underline()
                    .foregroundColor(.gray)
                    .padding(.horizontal, 16)
                TextEditor(text: $descriptionNote)
                    .foregroundColor(.gray)
                    .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(.green, lineWidth: 2)
                    )
                    .padding(.horizontal, 12)
                    .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                Button("Crear"){
                    notesViewModel.saveNote(description: descriptionNote)
                    descriptionNote = ""
                }
                .buttonStyle(.bordered)
                .tint(.green)
                Spacer()
                List{
                    ForEach($notesViewModel.notes, id: \.id) {
                        $note in HStack{
                            if note.isFavorited{
                                Text("⭐️")
                            }
                            Text(note.description)
                        }
                        .swipeActions(edge:.trailing){
                            Button{
                            
                                notesViewModel.updateFavoriteNotes(note: $note)
                            }label:{
                                Label("Favorito", systemImage: "start.fill")
                            }
                            .tint(.yellow)
                        }
                        .swipeActions(edge:.leading){
                            Button{
                                notesViewModel.removeNotes(withId: note.id)
                            }label:{
                                Label("Favorito", systemImage: "trash.fill")
                            }
                                .tint(.red)
                        }
                    }
                }
            }
            .navigationTitle("TODO")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                Text(notesViewModel.getNumbersOfNotes())
            }
        }
    }
}

#Preview {
    ContentView()
}
