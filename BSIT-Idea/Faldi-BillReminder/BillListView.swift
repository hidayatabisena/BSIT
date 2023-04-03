//
//  BillListView.swift
//  BSIT-Idea
//
//  Created by Hidayat Abisena on 02/04/23.
//

import SwiftUI

struct BillListView: View {
    @StateObject private var viewModel = BillListViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.bills) { bill in
                    BillRowView(bill: bill)
                }
                .onDelete(perform: viewModel.deleteBills)
            }
            .listStyle(.insetGrouped)
            .navigationBarTitle("Bills")
            .navigationBarItems(trailing: Button(action: {
                viewModel.showAddBillView = true
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $viewModel.showAddBillView) {
                AddBillView()
            }
        }
    }
}


struct BillListView_Previews: PreviewProvider {
    static var previews: some View {
        BillListView()
    }
}

struct BillRowView: View {
    let bill: Bill

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(bill.name)
                    .font(.headline)
                Text("\(bill.amount, specifier: "%.2f")")
                    .font(.subheadline)
                Text(bill.dueDate, style: .date)
                    .font(.subheadline)
            }
            .onReceive(NotificationCenter.default.publisher(for: UserDefaults.didChangeNotification)) { _ in
                // Update view setelah UserDefaults berubah
//                let updatedBill = loadBill()
//                bill = updatedBill
            }
            Spacer()
        }
    }
}

class BillListViewModel: ObservableObject {
    @Published var bills = [Bill]()
    @Published var showAddBillView = false
    
    init() {
        if let data = UserDefaults.standard.array(forKey: "bills") as? [Data] {
            self.bills = data.compactMap { try? JSONDecoder().decode(Bill.self, from: $0) }
        }
    }


//    init() {
//        let key = "bills"
//        if let data = UserDefaults.standard.data(forKey: key) {
//            do {
//                self.bills = try JSONDecoder().decode([Bill].self, from: data)
//            } catch {
//                print("Error decoding bills data: \(error.localizedDescription)")
//            }
//        }
//    }


    func deleteBills(at offsets: IndexSet) {
        bills.remove(atOffsets: offsets)
        
        var billDataArray = [[String: Any]]()
        if let data = UserDefaults.standard.array(forKey: "bills") as? [Data] {
            billDataArray = data.compactMap { try? JSONSerialization.jsonObject(with: $0, options: []) as? [String: Any] }
        }
        let indexesToRemove = Array(offsets)
        billDataArray.remove(atOffsets: IndexSet(indexesToRemove))
        
        let newData = billDataArray.compactMap { try? JSONSerialization.data(withJSONObject: $0, options: []) }
        UserDefaults.standard.set(newData, forKey: "bills")
        
        // Print data di UserDefaults setelah delete
        if let data = UserDefaults.standard.array(forKey: "bills") as? [Data] {
            print(data)
        }
    }


}


