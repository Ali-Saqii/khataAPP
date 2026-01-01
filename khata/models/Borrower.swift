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
struct Borrower: Identifiable, Hashable {
    let id = UUID().uuidString
    var name: String
    var imageName: String
    var borrowedItems: [Item]
    var paidAmount: Double = 0
    var totalAmount: Double
}

struct Item: Identifiable, Hashable {
    let id = UUID().uuidString
    var name: String
    var price: Double
}
