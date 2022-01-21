//
//  Home.swift
//  Notas
//
//  Created by MacBook J&J  on 20/01/22.
//

import SwiftUI

struct Home: View {
    @StateObject var model = ViewModel()
    @Environment(\.managedObjectContext) var conext
    
    @FetchRequest(entity: Notas.entity(), sortDescriptors: [NSSortDescriptor(key: "fecha", ascending: true)],  animation: .spring()) var results: FetchedResults<Notas>
    
    var body: some View {
        NavigationView{
            List{
                ForEach(results) { item in
                    VStack(alignment: .leading) {
                        Text(item.nota ?? "")
                            .font(.title)
                            .bold()
                        Text(item.fecha ?? Date(), style: .date)
                    }.contextMenu { //Menu Conextual
                        Button {
                            model.sendData(item: item)
                        } label: {
                            Text("Editar")
                            Image(systemName: "pencil")
                        }
                        
                        Button {
                            model.deleteData(context: conext, item: item)
                        } label: {
                            Text("Eliminar")
                            Image(systemName: "trash")
                        }
                    }
                }
                
            }.navigationTitle("Notas")
                .toolbar {
                    Button {
                        model.show.toggle()
                        model.resetData()
                    } label: {
                        Image(systemName: "plus")
                            .font(.title)
                            .foregroundColor(.blue)
                    }
                }.sheet(isPresented: $model.show) {
                    addView(model: model)
                }
        }
    }
}

