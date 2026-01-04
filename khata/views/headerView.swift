//
//  headerView.swift
//  khata
//
//  Created by Mac mini on 01/01/2026.
//

import SwiftUI

struct headerView: View {
    var body: some View {
        HStack(spacing: 10) {
           Image("book")
                .resizable()
                .frame(width: 70, height: 70)
                .padding(.horizontal)
                .shadow(radius: 20)
            Text("List of borrowers".capitalized)
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.black)
            Spacer()
            
        }.frame(maxWidth: .infinity)
            .frame(height:100)
        .background(
            LinearGradient(gradient: Gradient(colors: [.purple.opacity(1),.blue.opacity(1)]), startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .cornerRadius(20)
       
    }
}

//#Preview {
//    headerView()
//}
