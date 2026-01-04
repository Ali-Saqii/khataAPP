//
//  contentunavaliableView.swift
//  khata
//
//  Created by Mac mini on 03/01/2026.
//

import SwiftUI

struct contentunavaliableView: View {
    
    let title:String
    let image: String
    let descrption: String
    
    var body: some View {
        
        VStack(spacing:30) {
            Text(title)
                .font(.title.bold())
                .foregroundStyle(
                    LinearGradient(gradient: Gradient(colors: [.purple.opacity(1),.blue.opacity(1)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                )
            Image(systemName: image)
                .font(.system(size: 60))
                .foregroundStyle(
                    LinearGradient(gradient: Gradient(colors: [.purple.opacity(1),.blue.opacity(1)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                )
          Text(descrption)
                .foregroundStyle(
                    LinearGradient(gradient: Gradient(colors: [.purple.opacity(1),.blue.opacity(1)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .font(.headline)
                .lineLimit(3)
                .multilineTextAlignment(.center)

        }
    }
}
