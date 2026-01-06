//
//  addBorrowerView.swift
//  khata
//
//  Created by Mac mini on 04/01/2026.
//

import SwiftUI

struct addBorrowerView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel

    @State var borrowerName: String = ""
    @State var borrowerPhone: String = ""
    @Binding var ispresented:Bool

    
    var body: some View {
        VStack {
            VStack{
                Text("New Borrower")
                    .foregroundStyle(
                        LinearGradient(gradient: Gradient(colors: [.purple.opacity(1),.blue.opacity(1)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .font(.title.bold())
                Image("book")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .padding(.bottom)
                
                TextField("Borrower Name",text: $borrowerName)
                    .padding()
                    .foregroundStyle(.black)
                    .background(.gray.opacity(0.6))
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal,30)
                
                TextField("phone Number".capitalized,text: $borrowerPhone)
                    .padding()
                    .foregroundStyle(.black)
                    .background(.gray.opacity(0.6))
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal,30)
                    .padding(.vertical,25)
                Button(action: {
                    saveBorrower()
                    SoundManager.shared.playSound(named: "sound2")
                },
                       
                       label: {
                    Text("Save".uppercased())
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(width:250,height: 55)
                    //                    .frame(maxWidth: .infinity)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [.purple.opacity(1),.blue.opacity(1)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            
                        )
                        .cornerRadius(10)
                })
            }
            .padding()
            .background(
                LinearGradient(gradient: Gradient(colors: [.purple.opacity(0.4),.blue.opacity(0.4)]), startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .clipShape(RoundedRectangle(cornerRadius:10))
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
                        ispresented = false
                    }
                    .padding()
                
            }
//            .shadow(radius:10)
//            .padding(.horizontal,25)
            
        }.background(
        )
        .clipShape(RoundedRectangle(cornerRadius:10))
        .shadow(radius:10)
        .padding(.horizontal,25)
    }
    private func saveBorrower() {
        let name = borrowerName.trimmingCharacters(in: .whitespacesAndNewlines)
        let phone = borrowerPhone.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !name.isEmpty, !phone.isEmpty else { return }

        homeViewModel.addBorrower(name: name, phoneNo: phone)

        borrowerName = ""
        borrowerPhone = ""
        ispresented = false
    }
}

//#Preview {
//    NavigationView {
//        addBorrowerView()
//    }
//    .environmentObject(HomeViewModel())
//}

