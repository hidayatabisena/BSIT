//
//  PrayerView.swift
//  BSIT-Idea
//
//  Created by Hidayat Abisena on 02/04/23.
//

import SwiftUI

struct PrayerView: View {
    
    @State var prayers: [Prayer] = [
        Prayer(name: "Dhuha", time: Calendar.current.date(bySettingHour: 8, minute: 0, second: 0, of: Date())!),
        Prayer(name: "Shaum", time: Calendar.current.date(bySettingHour: 18, minute: 0, second: 0, of: Date())!)
    ]
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()
    
    @State private var showingAddPrayerAlert = false
    @State private var newPrayerName = "Qiyamul Lail"
    
    
    var body: some View {
        NavigationStack {
            List(prayers) { prayer in
                VStack(alignment: .leading) {
                    Text(prayer.name)
                    DatePicker(
                        "Select Time",
                        selection: self.binding(for: prayer),
                        displayedComponents: [.hourAndMinute]
                    )
                }
            }
            .navigationBarTitle("Prayer Reminder")
            .navigationBarItems(trailing: addButton)
            .alert(isPresented: $showingAddPrayerAlert) {
                Alert(
                    title: Text("New Prayer"),
                    message: Text("Enter the name for the new prayer"),
                    primaryButton: .default(Text("Add")) {
                        self.addPrayer()
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }
    
    private func binding(for prayer: Prayer) -> Binding<Date> {
        guard let prayerIndex = self.prayers.firstIndex(where: { $0.id == prayer.id }) else {
            fatalError("Cannot find prayer in array")
        }
        return Binding<Date>(
            get: {
                self.prayers[prayerIndex].time
            },
            set: {
                self.prayers[prayerIndex].time = $0
            }
        )
    }
    
    private var addButton: some View {
        Button(action: {
            self.showingAddPrayerAlert.toggle()
        }) {
            Image(systemName: "plus")
        }
    }
    
    private func addPrayer() {
        self.prayers.append(Prayer(name: self.newPrayerName, time: Date()))
        // self.showingAddPrayerAlert = false
    }
}

struct PrayerView_Previews: PreviewProvider {
    static var previews: some View {
        PrayerView()
    }
}
