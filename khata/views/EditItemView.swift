//
//  EditItemView.swift
//  khata
//
//  Created by Mac mini on 03/01/2026.
//

import SwiftUI

struct EditItemView: View {

    @EnvironmentObject var homeViewModel: HomeViewModel
    @Environment(\.dismiss) private var dismiss

    let borrowerId: String
    let itemId: String

    @State private var itemName: String = ""
    @State private var itemPrice: String = ""

    // MARK: - Helper to fetch item safely from the current model
    private var currentItem: Item? {
        // Borrower exists?
        guard let borrower = homeViewModel.borrowers.first(where: { $0.id == borrowerId }) else {
            return nil
        }
        return borrower.borrowedItems.first(where: { $0.id == itemId })
    }
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.purple.opacity(0.3),.blue.opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea(edges: .all)
            VStack {
                Form {
                    Section("Item Details") {
                        TextField("Item Name", text: $itemName)
                            .textInputAutocapitalization(.words)
                        
                        TextField("Price", text: $itemPrice)
                            .keyboardType(.decimalPad)
                    }
                }
                
                Button {
                    saveItem()
                } label: {
                    Text("save item".capitalized)
                        .foregroundStyle(.white)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(maxWidth: 400)
                        .frame(width: 300, height: 70)
                }.background(
                    LinearGradient(gradient: Gradient(colors: [.purple.opacity(1),.blue.opacity(1)]), startPoint: .topLeading, endPoint: .bottomTrailing)

                )
                .cornerRadius(25)
            }
            .navigationTitle("Edit Item")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Cancel") {
                        dismiss()
                    }.fontWeight(.semibold)
                }
                
            }
        } .onAppear {
            loadItem()
        }
    }
    private func loadItem() {
        // Populate fields from the fetched item
        if let item = currentItem {
            itemName = item.name
            itemPrice = String(format: "%.2f", item.price)
        }
    }

    private func saveItem() {
        guard let price = Double(itemPrice) else { return }

        // Use the existing updateItem API from HomeViewModel
        homeViewModel.updateItem(
            borrowerId: borrowerId,
            itemId: itemId,
            newName: itemName.isEmpty ? nil : itemName,
            newPrice: price
        )
        dismiss()
    }
}
