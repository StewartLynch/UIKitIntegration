//
//  GuageViewSUI.swift
//  UIKIntegration
//
//  Created by Stewart Lynch on 2020-07-09.
//

import SwiftUI

struct GaugeViewSUI: UIViewRepresentable {
    @Binding var value: Int
    func makeUIView(context: Context) -> GaugeView {
        let gaugeView = GaugeView(frame: .zero)
        gaugeView.backgroundColor = .clear
        return gaugeView
    }
    
    func updateUIView(_ uiView: GaugeView, context: Context) {
        UIView.animate(withDuration: 1) {
            uiView.value = value
        }
    }
    
}
