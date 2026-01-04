//
//  HomeViewModel.swift
//  khata
//
//  Created by Mac mini on 31/12/2025.
//

import SwiftUI
internal import Combine


class HomeViewModel: ObservableObject, Identifiable {
    @Published var borrowers: [Borrower] = [] {
        didSet {
            saveToUserDefaults()
        }
    }

    private let borrowersKey = "khata.borrowers"


    init() {
        loadFromUserDefaults()
    }

    func addBorrower(name: String, phoneNo: String) {
        let newBorrower = Borrower(name: name, phoneNo: phoneNo, borrowedItems: [], payments: [])
        withAnimation {
            borrowers.append(newBorrower)
        }
    }


    func editBorrower(id: String, newName: String? = nil, newPhoneNo: String? = nil) {
        guard let idx = borrowers.firstIndex(where: { $0.id == id }) else { return }
        var updated = borrowers[idx]
        if let name = newName { updated.name = name }
        if let phone = newPhoneNo { updated.phoneNo = phone }
        borrowers[idx] = updated
    }


    func deleteBorrower(at offsets: IndexSet) {
        withAnimation {
            borrowers.remove(atOffsets: offsets)
        }
    }

    func deleteBorrower(id: String) {
        if let idx = borrowers.firstIndex(where: { $0.id == id }) {
            withAnimation { borrowers.remove(at: idx) }
        }
    }

    // MARK: - Add Item to Borrower
    func addItem(to borrowerId: String, itemName: String, price: Double) {
        guard let idx = borrowers.firstIndex(where: { $0.id == borrowerId }) else { return }
        var borrower = borrowers[idx]
        let newItem = Item(name: itemName, price: price)
        borrower.borrowedItems.append(newItem)
        borrowers[idx] = borrower
    }


    func updateItem(borrowerId: String, itemId: String, newName: String? = nil, newPrice: Double? = nil) {
        guard let bIdx = borrowers.firstIndex(where: { $0.id == borrowerId }) else { return }
        var borrower = borrowers[bIdx]

        guard let iIdx = borrower.borrowedItems.firstIndex(where: { $0.id == itemId }) else { return }
        var item = borrower.borrowedItems[iIdx]
        if let name = newName { item.name = name }
        if let price = newPrice { item.price = price }

        borrower.borrowedItems[iIdx] = item
        borrowers[bIdx] = borrower
    }

    
    func addPayment(to borrowerId: String, amount: Double, date: Date = .now) {
        guard let idx = borrowers.firstIndex(where: { $0.id == borrowerId }) else { return }
        var borrower = borrowers[idx]
        let payment = Payment(amount: amount, date: date)
        borrower.payments.append(payment)
        borrowers[idx] = borrower
    }

    
    func transactionHistory(for borrowerId: String) -> [Payment] {
        guard let borrower = borrowers.first(where: { $0.id == borrowerId }) else { return [] }
        return borrower.payments.sorted { $0.date < $1.date }
    }

 
    private func saveToUserDefaults() {
        do {
            let data = try JSONEncoder().encode(borrowers)
            UserDefaults.standard.set(data, forKey: borrowersKey)
        } catch {
            print("Failed to save borrowers: \(error)")
        }
    }

    private func loadFromUserDefaults() {
        guard let data = UserDefaults.standard.data(forKey: borrowersKey) else { return }
        do {
            let savedBorrowers = try JSONDecoder().decode([Borrower].self, from: data)
            borrowers = savedBorrowers
        } catch {
            print("Failed to load borrowers: \(error)")
        }
    }
}

