//
//  LocationView.swift
//  BSIT-Idea
//
//  Created by Hidayat Abisena on 02/04/23.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    let mapView = MKMapView()
    @Binding var selectedLocation: CLLocationCoordinate2D?
    @Binding var showBookingForm: Bool
    
    func makeUIView(context: Context) -> MKMapView {
        mapView.showsUserLocation = true
        let jakartaLocation = CLLocation(latitude: -6.21462, longitude: 106.84513)
        let coordinateRegion = MKCoordinateRegion(center: jakartaLocation.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(coordinateRegion, animated: true)
        
        // create and add annotation
        let annotation = MKPointAnnotation()
        annotation.coordinate = jakartaLocation.coordinate
        annotation.title = "Hei Counselor"
        mapView.addAnnotation(annotation)
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        if let location = selectedLocation {
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            mapView.addAnnotation(annotation)
            mapView.setRegion(MKCoordinateRegion(center: location, latitudinalMeters: 10000, longitudinalMeters: 10000), animated: true)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let identifier = "Placemark"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            
            if annotationView == nil {
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
                annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            } else {
                annotationView?.annotation = annotation
            }
            
            return annotationView
        }
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            parent.showBookingForm = true
        }
    }
    
}


struct LocationView: View {
    @State private var selectedLocation: CLLocationCoordinate2D?
    @State private var showBookingForm = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                MapView(selectedLocation: $selectedLocation, showBookingForm: $showBookingForm)
                
                VStack {
                    Button {
                        self.showBookingForm = true
                    } label: {
                        Text("Book Appointment")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .offset(y: 50)

                }
            }
            .sheet(isPresented: $showBookingForm, content: {
                BookingFormView()
            })
            .edgesIgnoringSafeArea(.all)
        }
    }
}


struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
    }
}


