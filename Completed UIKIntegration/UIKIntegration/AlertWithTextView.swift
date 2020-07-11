//
//  AlertWithTextView.swift
//  UIKIntegration
//
//  Created by Stewart Lynch on 2020-07-09.
//

import SwiftUI

struct AlertWithTextView: UIViewControllerRepresentable {

    
    @Binding var showTextAlert: Bool
    @Binding var alertText: String
    let title: String
    let message: String
    let textPlaceholder: String
    
    func makeUIViewController(context: Context) -> UIViewController {
        UIViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        guard context.coordinator.alert == nil else { return }
        if showTextAlert {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            context.coordinator.alert = alert
            alert.addTextField { textField in
                textField.placeholder = textPlaceholder
                textField.text = ""
            }

            // As usual adding actions
            alert.addAction(UIAlertAction(title: "Cancel" , style: .destructive) { _ in
                alert.dismiss(animated: true) {
                    showTextAlert = false
                }
            })

            alert.addAction(UIAlertAction(title: "Submit", style: .default) { _ in
                if let textField = alert.textFields?.first,
                   let text = textField.text {
                    alertText = "Hi, \(text)"
                }
                alert.dismiss(animated: true) {
                    showTextAlert = false
                }
            })
            DispatchQueue.main.async {
                uiViewController.present(alert,animated: true) {
                    showTextAlert = false
                    context.coordinator.alert = nil
                }
            }
        }
    }
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject {
        var alert: UIAlertController?
    }
}
