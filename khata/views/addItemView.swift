//
//  addItemView.swift
//  khata
//
//  Created by Mac mini on 03/01/2026.
//

import SwiftUI

struct addItemView: View {
    
    @EnvironmentObject var homeViewModel: HomeViewModel
    @Environment(\.dismiss) private var dismiss

    let borrowerId: String

    @State private var itemName = ""
    @State private var itemPrice = ""
    
    var body: some View {
        ScrollView {
            VStack {
                
                Section {
                    
                    
                    TextField("Type something here...", text: $itemName)
                        .padding(.horizontal)
                        .frame(height: 55)
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(10)
                } header: {
                    Text("Item Name")
                        .frame(maxWidth: .infinity,alignment: .leading)
                }
                Section {
                    
                    
                    TextField("Type something here...", text: $itemPrice)
                        .padding(.horizontal)
                        .frame(height: 55)
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(10)
                } header: {
                    Text("Item Price")
                        .frame(maxWidth: .infinity,alignment: .leading)
                }
                
                Button(action: {saveItem()}, label: {
                    Text("Save".uppercased())
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [.purple.opacity(1),.blue.opacity(1)]), startPoint: .topLeading, endPoint: .bottomTrailing)

                        )
                        .cornerRadius(10)
                }).padding(.vertical,100)
            }
            .padding(14)
            .overlay(alignment: .topTrailing) {
                Image(systemName: "x.circle")
                    .font(.system(size: 35))
                    .fontWeight(.semibold)
                    .frame(width: 45, height: 45)
                    .background(
                        Circle()
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [.purple.opacity(1),.blue.opacity(1)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                    ).shadow(radius: 10)
                    .onTapGesture {
                    dismiss()
                    }
                    .padding(.horizontal)
            }
            .padding(.vertical)
        }.background(
            LinearGradient(gradient: Gradient(colors: [.purple.opacity(0.3),.blue.opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomTrailing)

        )
        .navigationTitle("Add an Item 🖊")


    }
    
    private func saveItem() {
        guard let price = Double(itemPrice) else { return }

        homeViewModel.addItem(
            to: borrowerId,
            itemName: itemName,
            price: price
        )
        dismiss()
    }
}

#Preview {
    addItemView(borrowerId: "preview-id")
        .environmentObject(HomeViewModel())
}
