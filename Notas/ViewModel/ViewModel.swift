//
//  ViewModel.swift
//  Notas
//
//  Created by MacBook J&J  on 20/01/22.
//
import Foundation
import Combine
import SwiftUI
import CoreData


class ViewModel: ObservableObject {
    @Published var nota = ""
    @Published var fecha = Date()
    @Published var show = false
    @Published var updateItem : Notas!
    
    // CoreData
    
    func saveData(context: NSManagedObjectContext) {
        let newNota = Notas(context: context)
        newNota.nota = self.nota
        newNota.fecha = self.fecha
        
        do {
            try context.save()
            print("Guardado exitoso")
            self.show.toggle()
        } catch let error as NSError {
            print("No se guardo la nota", error.localizedDescription)
        }
    }
    
    func deleteData(context: NSManagedObjectContext, item: Notas){
        context.delete(item)
        do {
            try context.save()
            print("Se elimino la nota correctamente")
        } catch let error as NSError {
            print("No se eliminio la nota", error.localizedDescription )
        }
    }
    
    func sendData(item: Notas) {
        self.updateItem  = item
        self.nota = item.nota ?? ""
        self.fecha = item.fecha ?? Date()
        self.show.toggle()
    }
    
    func editData(context: NSManagedObjectContext) {
        self.updateItem.nota = self.nota
        self.updateItem.fecha = self.fecha
        
        do {
            try context.save()
            self.show.toggle()
            print("Se edito correctamente")
        } catch let error as NSError{
            print("No se pudo Editar la nota", error.localizedDescription)
        }
    }
    
    func resetData(){
        self.updateItem = nil
        self.nota = ""
        self.fecha = Date()
    }
}
