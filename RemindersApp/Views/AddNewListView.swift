//
//  AddNewListView.swift
//  RemindersApp
//
//  Created by Santanu Agarwal on 18/05/24.
//

import SwiftUI

struct AddNewListView: View {
    @Environment(\.dismiss) private var dismiss
    
    let onSave: (String, UIColor) -> Void
    
    @State private var name: String = ""
    @State private var selectedColor: Color = .green
    
    private var isFormValid: Bool {
        !name.isEmpty
    }
    
    var body: some View {
        VStack {
            VStack {
                Image(systemName: "line.3.horizontal.circle.fill")
                    .foregroundStyle(selectedColor)
                    .font(.system(size: 100))
                TextField("List Name", text: $name)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(.roundedBorder)
            }
            .padding(30)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            ColorPickerView(selectedColor: $selectedColor)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .toolbar{
            ToolbarItem(placement: .principal) {
                Text("My List")
                    .font(.headline)
            }
            
            ToolbarItem(placement: .topBarLeading) {
                Button("Close") {
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("Done") {
                    onSave(name, UIColor(selectedColor))
                    dismiss()
                }
                .disabled(!isFormValid)
            }
        }
    }
}

#Preview {
    NavigationView{
        AddNewListView(onSave: {(_, _) in })
    }
}
