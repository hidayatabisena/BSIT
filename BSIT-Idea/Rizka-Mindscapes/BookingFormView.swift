//
//  BookingFormView.swift
//  BSIT-Idea
//
//  Created by Hidayat Abisena on 02/04/23.
//

import SwiftUI

struct BookingFormView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var date: Date = Date()
    
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Personal Information")) {
                    TextField("Name", text: $name)
                    TextField("Email", text: $email)
                }
                Section(header: Text("Booking Information")) {
                    DatePicker("Date", selection: $date)
                }
                Section {
                    Button(action: {
                        // send data to server
                        self.presentationMode.wrappedValue.dismiss()
                        
                    }) {
                        Text("Book Appointment")
                    }
                }
            }
            .navigationTitle("Book Appointment")
        }
    }
}


struct BookingFormView_Previews: PreviewProvider {
    static var previews: some View {
        BookingFormView()
    }
}
