//
//  Borrower.swift
//  khata
//
//  Created by Mac mini on 31/12/2025.
//

import Foundation
import SwiftUI
internal import Combine

// MARK: - Models
struct Borrower: Identifiable, Hashable,Codable {

    let id = UUID().uuidString
    var name: String
    var phoneNo: String 

    var borrowedItems: [Item]
    var payments: [Payment] = []

    // MARK: - Computed Properties

    var totalBorrowedAmount: Double {
        borrowedItems.reduce(0) { $0 + $1.price }
    }

    var totalPaidAmount: Double {
        payments.reduce(0) { $0 + $1.amount }
    }

    var remainingAmount: Double {
        max(0, totalBorrowedAmount - totalPaidAmount)
    }

    var initialise: String? {
        let formatter = PersonNameComponentsFormatter()
        guard let components = formatter.personNameComponents(from: name) else { return nil }
        formatter.style = .abbreviated
        return formatter.string(from: components)
    }
}


struct Item: Identifiable, Hashable,Codable {
    let id = UUID().uuidString
    var name: String
    var price: Double
}
struct Payment: Identifiable, Hashable,Codable {
    let id = UUID().uuidString
    let amount: Double
    let date: Date
}
