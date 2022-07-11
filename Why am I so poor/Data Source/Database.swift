//
//  Database.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/4/22.
//

import Foundation
import UIKit
import Firebase

public enum VoidResult {
    case success
    case failure(Error)
}

class Database {
    static let shared = Database()
    
    private var merchantList = [String]()
    
    struct Collections {
        static let transactions = "transactions"
        static let budgets = "budgets"
    }
    
    struct FieldNames {
        static let month = "month"
        static let userId = "userId"
        static let categoryId = "categoryId"
    }
    
    enum FirebaseError: Error {
        case snapshotMissing
        case multipleDocumentUsingSameID
        case dataKeyMissing
        case entryInitFailure
        case userMissing
        case documentMissing
        case invalidDocumentID
    }
    
    init() {
        setup()
    }
}
// MARK: - Setup
extension Database {
    private func setup() {
        fetchMerchants()
    }
}
// MARK: - Fetch
extension Database {
    private func fetchMerchants() {
        merchantList.append("FairPrice")
        merchantList.append("Apple")
        merchantList.append("7-11")
        merchantList.append("Anytime Fitness")
        merchantList.append("Circle Life")
        merchantList.append("Grab Food")
        merchantList.append("FoodPanda")
        merchantList.append("KFC")
        merchantList.append("Pho Street")
        merchantList.append("One North Dental")
        merchantList.append("Padlet")
        merchantList.append("Apple Music")
        merchantList.append("Spotify")
        merchantList.append("Amazon.com")
        merchantList.append("Shopee")
        merchantList.append("Lazada")
        merchantList.append("Raffles Medical")
        merchantList.append("Hydro Flask")
        merchantList.append("Ichiran Ramen")
        merchantList.append("Golden Village")
    }
    
    func getAllMerchants() -> [String] {
        // TODO: -
        return merchantList
    }
    // month: 1-12
    func getMonthlyTransactions(in month: Int, of category: Category? = nil) -> [Transaction] {
        // TODO: - Link to Firebase
        if let category = category {
            return Transaction.testEntries
        }
        return Transaction.testEntries
    }
    func getMonthlyTransactions(in month: Int,
                                of category: Category? = nil,
                                completion: @escaping(Result<[Transaction], Error>) -> Void) {
        
        var ref = Firestore.firestore().collection(Collections.transactions).whereField(FieldNames.month, isEqualTo: month)
        if let category = category {
            ref = ref.whereField(FieldNames.categoryId, isEqualTo: category.id)
        }
        
        ref.getDocuments { snapshot, error in
            if let error = error {
                return completion(.failure(error))
            }
            guard let snapshot = snapshot else {
                return completion(.failure(FirebaseError.snapshotMissing))
            }
            
            let entries: [Transaction] = snapshot
                .documentChanges
                .filter { $0.type == .added }
                .compactMap { try? Transaction(snapshot: $0.document) }
            return completion(.success(entries))
        }
    }
    func getDailyTransactions(on date: Date, of category: Category? = nil) -> [Transaction] {
        // TODO: - Link to Firebase
        return Transaction.testEntries
    }
    func getBudgetList() -> [Budget] {
        // TODO: - Link to Firebase
        return Budget.testEntries
    }
}

// MARK: - Calculation
extension Database {
    func sum(of transactions: [Transaction]) -> Double {
        return transactions.reduce(0) { $0 + $1.signedAmount }
    }
}

// MARK: - Update
extension Database {
    /// Add new transaction
    func addData(of transaction: Transaction, completion: @escaping (VoidResult) -> Void) {
        let collectionRef = Firestore.firestore().collection(Collections.transactions)
        do {
            _ = try collectionRef.addDocument(from: transaction, completion: { error in
                if let error = error {
                    return completion(.failure(error))
                }
                return completion(.success)
            })
        } catch {
            return completion(.failure(FirebaseError.entryInitFailure))
        }
    }
    func updateData(of transaction: Transaction, completion: @escaping (VoidResult) -> Void) {
        // TODO: - update data
        print("request to update transaction \(transaction.id)")
        return
    }
    func updateData(at transactionId: String, _ field: Transaction.EditableFields, to value: String, completion: @escaping (VoidResult) -> Void) {
        // TODO: - update data
        print("request to update transaction \(transactionId) of \(field) to \(value)")
        return
    }
    func updateData(of budgets: [Budget]) {
        // TODO: - update data
    }
}
