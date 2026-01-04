//
//  HomwView.swift
//  khata
//
//  Created by Mac mini on 01/01/2026.
//

import SwiftUI

struct HomwView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel

    @State var addBorrower: Bool = false
    
    var body: some View {
        NavigationStack{
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.purple.opacity(0.3),.blue.opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea(edges: .all)
                
                VStack {
                    headerView()
                    Divider()
                    if homeViewModel.borrowers.isEmpty {
                        noBorrowerView()
                            .transition(AnyTransition.opacity.animation(.easeIn))
                    }else{
                        ScrollView(showsIndicators: false) {
                            ForEach(homeViewModel.borrowers) { borrower in
                                NavigationLink {
                                    borrowerDetailsView(borrowerId: borrower.id)
                                        .environmentObject(homeViewModel) // Inject VM here

                                } label: {
                                    borrowerRowView(
                                        initiliase: borrower.initialise,
                                        name: borrower.name,
                                        paidAmount: Int(borrower.totalPaidAmount)
                                    )
                                }
                            }

                        }  .overlay(alignment: .bottomTrailing) {
                            Button {
                              addBorrower = true
                            } label: {
                                Image(systemName: "plus")
                                    .foregroundStyle(.black)
                                    .font(.largeTitle)
                                    .fontWeight(.semibold)
                                    .frame(width: 60, height: 60)
                            }.background {
                                Circle()
                                    .fill(
                                        LinearGradient(gradient: Gradient(colors: [.purple.opacity(1),.blue.opacity(1)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                    )
                            }
                            .padding()
                            
                        }
                    }
                    

                }.padding(.horizontal)

                if addBorrower {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .onTapGesture {
                            addBorrower = false
                        }

                    addBorrowerView(ispresented: $addBorrower)
                        .environmentObject(homeViewModel)
                        .transition(AnyTransition.asymmetric(insertion: .scale, removal: .opacity))
                        .zIndex(1)
                }

            }.animation(.easeInOut(duration: 0.5), value: addBorrower)
        }.environmentObject(homeViewModel)
    }
}

#Preview {
    NavigationView {
        HomwView()
    }
    .environmentObject(HomeViewModel())
}
