//
//  NoteViewModel.swift
//  toDoList
//
//  Created by Edward Mayk on 24/10/23.
//

import Foundation
import SwiftUI

final class NoteViewModel: ObservableObject{
    @Published var notes: [NoteModel] = []
    
    init(){
        notes = getAllNotes()
    }
    
    func saveNote(description: String){
        let newNote = NoteModel(description: description)
        notes.insert(newNote, at:0)
        encodeAndSaveAllNotes()
    }
    private func encodeAndSaveAllNotes(){
        if let encoded = try? JSONEncoder().encode(notes){
            UserDefaults.standard.set(encoded, forKey: "notes")
        }
    }
    
    func getAllNotes() -> [NoteModel]{
        if let notesData = UserDefaults.standard.object(forKey: "notes") as? Data{
            if let notes = try? JSONDecoder().decode([NoteModel].self, from: notesData){
                return notes
            }
        }
        return []
    }
    
    func removeNotes(withId id: String){
        notes.removeAll(where: {$0.id == id})
        encodeAndSaveAllNotes()
    }
    
    func updateFavoriteNotes(note: Binding<NoteModel>){
        note.wrappedValue.isFavorited = !note.wrappedValue.isFavorited
        encodeAndSaveAllNotes()
    }
    func getNumbersOfNotes() -> String {
        "\(notes.count)"
    }
}
