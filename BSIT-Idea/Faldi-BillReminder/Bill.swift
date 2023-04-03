//
//  Bill.swift
//  BSIT-Idea
//
//  Created by Hidayat Abisena on 02/04/23.
//

import Foundation

struct Bill: Identifiable, Codable {
    let id = UUID()
    var name: String
    var amount: Double
    var dueDate: Date
}
