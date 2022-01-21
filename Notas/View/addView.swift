//
//  addView.swift
//  Notas
//
//  Created by MacBook J&J  on 20/01/22.
//

import SwiftUI

struct addView: View {
    
    @ObservedObject var model: ViewModel
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        VStack{
            Text(model.updateItem != nil ? "Editar Nota" : "Agregar Nota")
                .font(.largeTitle)
                .bold()
            Spacer()
            TextEditor(text: $model.nota)// textField que abarca toda la pantalla, add paragrahps
            Divider() // a line for divide
            DatePicker("Seleccionar Fecha", selection: $model.fecha) // Calendar
            Spacer()
            Button(action:{
                if model.updateItem != nil {
                    model.editData(context: context)
                } else {
                    model.saveData(context: context)
                }
            }){
                Label {
                    Text("Guardar").foregroundColor(.white).bold()
                } icon: {
                    Image(systemName: "plus").foregroundColor(.white)
                }

            }.padding()
                .frame(width: UIScreen.main.bounds.width - 30)
                .background(model.nota == "" ? .gray : .blue)
                .cornerRadius(8)
                .disabled(model.nota == "" ? true : false)
                
            
        }.padding()
    }
}


