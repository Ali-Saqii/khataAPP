//
//  HomeViewModel.swift
//  khata
//
//  Created by Mac mini on 31/12/2025.
//

import SwiftUI
internal import Combine


class HomeViewModel: ObservableObject {
    @Published var borrowers: [Borrower] = [
        Borrower(name: "Ali", imageName: "person.fill", borrowedItems: []),
        Borrower(name: "Sara", imageName: "person.fill", borrowedItems: [])
    ]
    
    func addBorrower(name: String) {
        let newBorrower = Borrower(name: name, imageName: "person.fill", borrowedItems: [])
        withAnimation { borrowers.append(newBorrower) }
    }
    
    func deleteBorrower(at offsets: IndexSet) {
        withAnimation { borrowers.remove(atOffsets: offsets) }
    }
}

