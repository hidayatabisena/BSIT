//
//  EventListView.swift
//  BSIT-Idea
//
//  Created by Hidayat Abisena on 02/04/23.
//

import SwiftUI

// MARK: - Event Model
struct Event: Identifiable {
    let id = UUID()
    let name: String
    let location: String
    let date: Date
    let price: Double
    let imageCover: String
}

// MARK: - Event List
struct EventListView: View {
    // MARK: - PROPERTIES
    let events = [
        Event(name: "Islamic Intimacy 101", location: "Jakarta", date: Date(), price: 250000, imageCover: "ifthar"),
        Event(name: "Sacred Sexuality 101", location: "Bali", date: Date(), price: 150000, imageCover: "ifthar"),
        Event(name: "Pure Love: Islamic Sex Ed", location: "Surabaya", date: Date(), price: 100000, imageCover: "ifthar")
    ]
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            List(events) { event in
                NavigationLink(destination: EventDetail(event: event)) {
                    EventRow(event: event)
                }
            }
            .navigationTitle("Events")
        }
    }
}

// MARK: - PREVIEW
struct EventListView_Previews: PreviewProvider {
    static var previews: some View {
        EventListView()
    }
}

// MARK: - Event Row
struct EventRow: View {
    let event: Event
    
    var body: some View {
        HStack(spacing: 8) {
            Image(event.imageCover)
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .cornerRadius(10)
            
            VStack(alignment: .leading) {
                Text(event.name)
                    .font(.headline)
                
                Text(event.location)
                    .font(.subheadline)
            }
            Spacer()
            Text("Rp\(event.price, specifier: "%.f")")
                .font(.system(.callout))
        }
    }
}

// MARK: - Event Detail
struct EventDetail: View {
    let event: Event
    @State private var quantity = 1
    
    var body: some View {
        VStack(spacing: 8) {
            Image(event.imageCover)
                .resizable()
                .scaledToFit()
                .padding()
            
            Text(event.name)
                .font(.title)
            
            Text(event.location)
                .font(.headline)
                .foregroundColor(.secondary)
            
            Text("Rp\(event.price, specifier: "%.2f")")
                .font(.system(.callout))
            
            Text("\(event.date, formatter: DateFormatter())")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Stepper(value: $quantity, in: 1...10) {
                Text("Quantity: \(quantity)")
            }
            
            Spacer()
            
            Button(action: buyTicket) {
                Text("Buy Ticket")
            }
            .buttonStyle(.bordered)
            .tint(.blue)
            .controlSize(.large)
            .padding()
        }
        .padding()
        .navigationTitle("Event Detail")
    }
    
    func buyTicket() {
        let totalPrice = floor(event.price * Double(quantity))
        print("Purchased \(quantity) ticket(s) for \(event.name) for a total of Rp\(totalPrice)")
    }
}


