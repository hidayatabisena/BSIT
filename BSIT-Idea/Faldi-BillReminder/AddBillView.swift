//
//  AddBillView.swift
//  BSIT-Idea
//
//  Created by Hidayat Abisena on 02/04/23.
//

import SwiftUI

struct AddBillView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var name = ""
    @State private var amount = ""
    @State private var dueDate = Date()
    
    @StateObject private var viewModel = BillListViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Bill Details")) {
                    TextField("Name", text: $name)
                    TextField("Amount", text: $amount)
                        .keyboardType(.decimalPad)
                    DatePicker("Due Date", selection: $dueDate, displayedComponents: [.date])
                }
            }
            .navigationBarTitle("Add Bill")
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Save") {
                    saveBill(name: name, amount: amount, dueDate: dueDate)

                    presentationMode.wrappedValue.dismiss()
                }.disabled(name.isEmpty || amount.isEmpty)
            )
        }
    }
    
    func saveBill(name: String, amount: String, dueDate: Date) {
        let billAmount = Double(amount) ?? 0.0
        let newBill = Bill(name: name, amount: billAmount, dueDate: dueDate)

        if var bills = UserDefaults.standard.array(forKey: "bills") as? [Data] {
            if let encodedBill = try? JSONEncoder().encode(newBill) {
                bills.append(encodedBill)
                UserDefaults.standard.set(bills, forKey: "bills")
            }
        } else {
            if let encodedBill = try? JSONEncoder().encode([newBill]) {
                UserDefaults.standard.set([encodedBill], forKey: "bills")
                print("Data berhasil ditambahkan ke dalam UserDefaults")
            }
        }
    }

}


struct AddBillView_Previews: PreviewProvider {
    static var previews: some View {
        AddBillView()
    }
}
