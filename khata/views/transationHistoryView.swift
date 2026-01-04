//
//  transationHistoryView.swift
//  khata
//
//  Created by Mac mini on 04/01/2026.
//

import SwiftUI

struct transationHistoryView: View {
    let payment:[Payment]
    let borrowerName: String
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            Text("\(borrowerName)".capitalized)
                .foregroundStyle(
                    LinearGradient(
                        gradient: Gradient(colors: [.purple.opacity(1),.blue.opacity(1)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )

                )
                .lineLimit(1)
                .font(.title)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.horizontal)
                
            
            ScrollView(showsIndicators:false) {
                
                if payment.isEmpty {
                    contentunavaliableView(
                        title: "No history found".capitalized,
                        image: "questionmark",
                        descrption: "No payments recorded yet. Add a payment to start tracking this borrower’s transactions."
                        )
                    .padding(.horizontal)
                }else {
                    ForEach(payment) { payment in
                        HStack {
                            VStack {
                                Text("\(payment.amount, specifier: "%.2f")")
                                    .foregroundStyle(.black)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                Text("price".capitalized)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                            }
                            Spacer()
                                Text("\(payment.date)")
                                    .font(.title2)
  
                        }.padding(.horizontal)

                        Divider()
                    }
                }

            }
        }.background(
            LinearGradient(gradient: Gradient(colors: [.purple.opacity(0.3),.blue.opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea(edges: .all)
        )
        .overlay(alignment:.topTrailing) {
            
            Image(systemName: "xmark")
                .font(.title2)
                .fontWeight(.medium)
                .foregroundStyle(.black)
                .frame(width: 40, height: 40)
                .background(
                    Circle()
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [.purple.opacity(1),.blue.opacity(1)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                )
                .onTapGesture {
                   dismiss()
                }
                .padding()
            
        }
        
        
    }
}
//#Preview {
//    transationHistoryView()
//}
