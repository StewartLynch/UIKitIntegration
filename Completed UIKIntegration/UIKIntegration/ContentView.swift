//
//  ContentView.swift
//  UIKIntegration
//
//  Created by Stewart Lynch on 2020-07-08.
//

import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var value: Int = 0
    @State private var showingImagePicker = false
    @State private var showTextAlert = false
    @State private var alertText = "Hello ??"
    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                GaugeViewSUI(value: $value)
                    .frame(width: 200, height: 200)
                Button(action: {
                    moveGauge()
                }){
                    Text("Move Gauge")
                        .frame(width: 120, height: 40)
                        .background(Color(UIColor.blue))
                        .cornerRadius(14)
                        .foregroundColor(.white)
                }
                Group {
                    if image == nil {
                        Rectangle()
                            .fill(Color(UIColor.lightGray))
                    }
                    else {
                        image!
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 200)
                            .clipped()
                            
                    }
                }
                .frame(width: 200, height: 200)
                Button(action: {
                    getImage()
                }){
                    Text("Get Image")
                        .frame(width: 120, height: 40)
                        .background(Color(UIColor.blue))
                        .cornerRadius(14)
                        .foregroundColor(.white)
                }
                .sheet(isPresented: $showingImagePicker) {
                    PHPickerView(image: $image)
                }
                Text(alertText)
                Button(action: {
                    showAlert()
                }){
                    Text("Enter name")
                        .frame(width: 120, height: 40)
                        .background(Color(UIColor.blue))
                        .cornerRadius(14)
                        .foregroundColor(.white)
                }
                Spacer()
            }
            if showTextAlert {
                AlertWithTextView(showTextAlert: $showTextAlert,
                                  alertText: $alertText,
                                  title: "Name",
                                  message: "Please enter your name,",
                                  textPlaceholder: "Full name")
            }
        }
    }
    
    func moveGauge() {
        value = 0
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                value += 20
            if value >= 100 {
                timer.invalidate()
            }
        }
    }
    
    func getImage() {
        showingImagePicker.toggle()
    }
    
    func showAlert() {
        showTextAlert.toggle()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
