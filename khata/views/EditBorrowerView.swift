//
//  EditBorrowerView.swift
//  khata
//
//  Created by Mac mini on 03/01/2026.
//

import SwiftUI

struct EditBorrowerView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    @Environment(\.dismiss) private var dismiss

    let borrowerId: String

    @State private var name = ""
    @State private var phone = ""

    // MARK: - Derived Borrower
    private var borrower: Borrower? {
          homeViewModel.borrowers.first(where: { $0.id == borrowerId })
      }
    var body: some View {
       ZStack {
            LinearGradient(gradient: Gradient(colors: [.purple.opacity(0.3),.blue.opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea(edges: .all)
            VStack {
                HStack {
                    Text("\(borrower?.initialise ?? "")")
                        .font(.largeTitle)
                        .frame(width: 150, height: 150)
                        .background(
                            Circle()
                            .fill( LinearGradient(gradient: Gradient(colors: [.purple.opacity(1),.blue.opacity(1)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                               
                        )
                        .shadow(color: .black,radius: 5)
                       
                }
                Form {
                    Section("Item Details") {
                        TextField("Borrower Name", text: $name)
                            .textInputAutocapitalization(.words)
                        
                        TextField("Phone No", text: $phone)
                            .keyboardType(.decimalPad)
                    }
                }
                
                Button {
                    saveBorrower()

                } label: {
                    Text("save Borrower".capitalized)
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
            .navigationTitle("Edit Borrower")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Cancel") {
                        dismiss()
                    }.fontWeight(.semibold)
                }
                
            }
        }.onAppear {
            loadBorrower()
        }
 
    }

    private func loadBorrower() {
        // Populate fields from the fetched borrower
        if let b = borrower {
            name = b.name
            phone = b.phoneNo
        }
    }

    private func saveBorrower() {
        guard let b = borrower else { return }
        // Update via the ViewModel
        homeViewModel.editBorrower(
            id: b.id,
            newName: name.isEmpty ? nil : name,
            newPhoneNo: phone.isEmpty ? nil : phone
        )
        dismiss()
    }
}

