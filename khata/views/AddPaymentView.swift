//
//  paymentView.swift
//  khata
//
//  Created by Mac mini on 04/01/2026.
//

import SwiftUI

struct AddPaymentView: View {
    let borrowerId: String
   
    @EnvironmentObject var homeViewModel: HomeViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var amountText: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.purple.opacity(0.3),.blue.opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea(edges: .all)
            
            VStack(spacing: 20) {
                Text("Add Payment")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 40)
                
                // Payment Amount Input
                TextField("Enter amount", text: $amountText)
                    .keyboardType(.decimalPad)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.2)))
                    .padding(.horizontal)
                
                Button {
                    savePayment()
                } label: {
                    Text("Pay")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [.purple, .blue]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .cornerRadius(15)
                        .padding(.horizontal)
                }
                
                Spacer()
            }
            .navigationTitle("Payment")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    private func savePayment() {
        guard let amount = Double(amountText), amount > 0 else {
            alertMessage = "Please enter a valid amount greater than 0."
            showAlert = true
            return
        }
        
        homeViewModel.addPayment(to: borrowerId, amount: amount)
        dismiss() // go back after adding payment
    }
}
