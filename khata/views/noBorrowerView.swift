//
//  noBorrowerView.swift
//  khata
//
//  Created by Mac mini on 04/01/2026.
//

import SwiftUI

struct noBorrowerView: View {
    @State var addborrower: Bool = false
    @State var animate: Bool = false
    let secondaryAccentColor = Color("noBorrowerColor")
    
    var body: some View {
        
        ZStack {
            ScrollView {
                VStack(spacing: 10) {
                    Text("There are no Borrowers!")
                        .font(.title)
                        .fontWeight(.semibold)
                    
                    Text("Are you a productive person? I think you should click the add button and add a bunch of borrowers to your khata App!")
                        .padding(.bottom, 20)
                    
                    Button{
                        addborrower  = true
                    }
                    label: {
                        Text("Add Borrower 🥳")
                            .foregroundColor(.white)
                            .font(.headline)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(animate ? secondaryAccentColor : Color.purple)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, animate ? 30 : 50)
                    .shadow(
                        color: animate ? secondaryAccentColor.opacity(0.7) : Color.purple.opacity(0.7),
                        radius: animate ? 30 : 10,
                        x: 0,
                        y: animate ? 50 : 30)
                    .scaleEffect(animate ? 1.1 : 1.0)
                    .offset(y: animate ? -7 : 0)
                }
                .frame(maxWidth: 400)
                .multilineTextAlignment(.center)
                .padding(40)
                .onAppear(perform: addAnimation)

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            if addborrower {
                addBorrowerView(ispresented: $addborrower)
                    .transition(AnyTransition.asymmetric(insertion: .scale, removal: .opacity))
                    .zIndex(1)
            }
            
        }.animation(.easeInOut(duration: 0.5), value: addborrower)
    }
    
    func addAnimation() {
        guard !animate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(
                Animation
                    .easeInOut(duration: 2.0)
                    .repeatForever()
            ) {
                animate.toggle()
            }
        }
    }
}

//#Preview {
//    noBorrowerView()
//}
