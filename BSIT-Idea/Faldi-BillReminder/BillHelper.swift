//
//  BillHelper.swift
//  BSIT-Idea
//
//  Created by Hidayat Abisena on 02/04/23.
//

import Foundation

func loadBills() -> [Bill] {
    guard let billData = UserDefaults.standard.data(forKey: "bills") else {
        return []
    }
    
    do {
        let decoder = JSONDecoder()
        let bills = try decoder.decode([Bill].self, from: billData)
        return bills
    } catch {
        print("Error decoding bills: \(error)")
        return []
    }
}
