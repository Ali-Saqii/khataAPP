//
//  borrowerRowView.swift
//  khata
//
//  Created by Mac mini on 01/01/2026.
//

import SwiftUI

struct borrowerRowView: View {
    
    let initiliase: String?
    let name: String
    let paidAmount: Int
    
    
    var body: some View {
        HStack  {
            Text("\(initiliase ?? "")")
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundStyle(.black)
                .frame(width: 50,height: 50)
                .background(
                    Circle()
                        .fill( LinearGradient(gradient: Gradient(colors: [.purple.opacity(1),.blue.opacity(1)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                )
                .padding(.horizontal)
            Text(name.capitalized)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(.black)
          Spacer()
            VStack {
                Text("\(Int(paidAmount))")
                    .foregroundStyle(.black)
                Text("paid Amount")
                    .font(.caption2)
                    .foregroundStyle(.black)
            }.padding(.horizontal)
        }.frame(maxWidth: .infinity)
            .frame(height: 65)
            .background( LinearGradient(gradient: Gradient(colors: [.purple.opacity(1),.blue.opacity(1)]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(10)
    }
}


