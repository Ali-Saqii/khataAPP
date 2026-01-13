//
//  borrowerDetailsView.swift
//  khata
//
//  Created by Mac mini on 01/01/2026.
//

import SwiftUI

struct borrowerDetailsView: View {
    let borrowerId: String
    
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    @State private var addItem = false
    @State private var editBorrowerView = false
    @State private var selectedItem: Item?
    @State private var transactionHistory = false
    @State private var payment: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    private var borrower: Borrower? {
        homeViewModel.borrowers.first(where: { $0.id == borrowerId })
    }
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.purple.opacity(0.3),.blue.opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea(edges: .all)
            
            VStack {
                borrowerDetailsViewHeader(
                    initiliase: borrower?.initialise,
                    name: borrower?.name ?? "",
                    PhoneNo: borrower?.phoneNo ?? "",
                    paidAmount: borrower?.totalPaidAmount ?? 0,
                    totalAmount: borrower?.totalBorrowedAmount ?? 0,
                    remainingAmount: borrower?.remainingAmount ?? 0
                )
                
                HStack {
                    Button {
                        payment = true
                        SoundManager.shared.playSound(named: "sound3")
                    } label: {
                        Text("Pay Price".capitalized)
                            .foregroundStyle(.black)
                            .frame(width: 150,height: 30)
                    }.background(
                        Capsule()
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [.purple.opacity(1),.blue.opacity(1)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                    )
                    Spacer()
                    Button {
                        transactionHistory = true
                        SoundManager.shared.playSound(named: "sound3")
                    } label: {
                        Text("transation Hiatory".capitalized)
                            .foregroundStyle(.black)
                            .padding(.horizontal)
                    }.background(
                        Capsule()
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [.purple.opacity(1),.blue.opacity(1)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                    )
                    
                }.padding(.horizontal,5)
                
                Divider()
                Section {
                    if borrower?.borrowedItems.isEmpty ?? true {
                        // ScrEmpty state view inside the section
                        ScrollView {
                            contentunavaliableView(
                                title: "No Items Available",
                                image: "tray.2.fill",
                                descrption: "This borrower has no recorded items yet. Add items to begin maintaining the ledger."
                            )
                        }
                    } else {
                        ScrollView(showsIndicators:false) {
                            ForEach(borrower?.borrowedItems ?? []) { item in
                                HStack {
                                    Text(item.name.capitalized)
                                        .foregroundStyle(.black)
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                    
                                    Spacer()
                                    VStack(alignment: .leading) {
                                        Text("\(item.price, specifier: "%.2f")")
                                            .font(.title2)
                                        Text("price".capitalized)
                                        
                                    }
                                }.padding(.horizontal)
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        selectedItem = item
                                    }
                                Divider()
                            }
                        }
                    }
                } header: {
                    Text("Items".capitalized)
                        .font(.title3)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                }
                
            }.toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        editBorrowerView = true
                        SoundManager.shared.playSound(named: "sound3")
                    } label: {
                        HStack(spacing: 6) {
                            Image(systemName: "pencil")
                                .foregroundStyle(
                                    LinearGradient(gradient: Gradient(colors: [.purple.opacity(1),.blue.opacity(1)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                )
                            Text("Edit Borrower")
                                .foregroundStyle(
                                    LinearGradient(gradient: Gradient(colors: [.purple.opacity(1),.blue.opacity(1)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                )
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 5)
                        .background(
                            Capsule()
                                .fill(.white.opacity(0.6))
                        ) // or your custom background
                    }
                    
                }/*.sharedBackgroundVisibility(.hidden)*/
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "trash.fill")
                    
                        .foregroundStyle(
                            LinearGradient(gradient: Gradient(colors: [.purple.opacity(1),.blue.opacity(1)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .onTapGesture {
                            homeViewModel.deleteBorrower(id: borrowerId)
                            dismiss()
                            SoundManager.shared.playSound(named: "sound3")
                        }
                }
                
            }
            
            .padding(.horizontal,3)
            .overlay(alignment: .bottomTrailing) {
                Text("Add Item")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding()
                    .padding(.leading,30)
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [.purple.opacity(1),.blue.opacity(1)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                            .offset(x:30)
                            .onTapGesture {
                                addItem = true
                            }
                        
                    )
            }
            .navigationDestination(item: $selectedItem) { item in
                EditItemView(
                    borrowerId: borrowerId,
                    itemId: item.id
                )
                .environmentObject(homeViewModel)            }
            .navigationDestination(isPresented: $editBorrowerView) {
                EditBorrowerView(borrowerId: borrowerId)
                    .environmentObject(homeViewModel)
            }
            .sheet(isPresented: $addItem) {
                
                addItemView(borrowerId: borrowerId)
                    .environmentObject(homeViewModel)
                    .presentationDetents([
                        .fraction(0.7),
                        .large
                    ])
                    .presentationDragIndicator(.hidden)
            }
            .fullScreenCover(isPresented: $transactionHistory) {
                transationHistoryView(payment: borrower?.payments ?? [], borrowerName: borrower?.name ?? "")
                    .presentationDetents([
                        .fraction(0.5),
                        .large
                    ])
                    .presentationDragIndicator(.hidden)
            }
            .sheet(isPresented: $payment) {
                AddPaymentView(borrowerId: borrowerId)
                    .environmentObject(homeViewModel)
                    .presentationDetents([.fraction(0.7)])
                    .presentationDragIndicator(.visible)
                
            }
        }
    }
    
    private struct borrowerDetailsViewHeader:View {
        let initiliase:String?
        let name:String
        let PhoneNo: String
        let paidAmount: Double
        let totalAmount: Double
        let remainingAmount: Double
        var body: some View {
            HStack {
                
                Text("\(initiliase ?? "")")
                    .font(.largeTitle)
                    .frame(width: 110, height: 110)
                    .background(
                        Circle()
                            .fill( LinearGradient(gradient: Gradient(colors: [.purple.opacity(1),.blue.opacity(1)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        
                    )
                    .shadow(color: .black,radius: 5)
                    .padding(.leading)
                Spacer()
                VStack(alignment:.leading) {
                    Text(name.capitalized)
                        .lineLimit(1)
                        .font(.title3.bold())
                    Text("\(PhoneNo)")
                        .font(.headline)
                        .fontWeight(.semibold)
                }
                Spacer()
                VStack(alignment:.trailing,spacing: 0) {
                    Text("total Price".capitalized)
                        .font(.caption)
                        .fontWeight(.semibold)
                    Text("\(totalAmount, specifier: "%.2f")")
                    
                        .font(.headline)
                        .fontWeight(.semibold)
                        .offset(y:-10)
                    Text("Paid AMount".capitalized)
                        .font(.caption)
                        .fontWeight(.semibold)
                    Text("\(paidAmount, specifier: "%.2f")")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .offset(y:-10)
                    Text("remaining Amount".capitalized)
                        .font(.caption)
                        .fontWeight(.semibold)
                    Text("\(remainingAmount, specifier: "%.2f")")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .offset(y:-10)
                }.frame(maxWidth: 150)
                    .padding(.trailing)
                
                
                
            }.frame(maxWidth: .infinity)
            
                .background(
                    LinearGradient(gradient: Gradient(colors: [.purple.opacity(1),.blue.opacity(1)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .cornerRadius(25)
            
        }
    }
}
#Preview {
    NavigationView {
        HomwView()
    }
    .environmentObject(HomeViewModel())
}
