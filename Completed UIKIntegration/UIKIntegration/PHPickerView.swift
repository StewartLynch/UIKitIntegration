//
//  PHPickerView.swift
//  UIKIntegration
//
//  Created by Stewart Lynch on 2020-07-09.
//

import SwiftUI
import PhotosUI

struct PHPickerView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var image:Image?
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
        
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: PHPickerView
        init(parent: PHPickerView) {
            self.parent = parent
        }
        
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            self.parent.presentationMode.wrappedValue.dismiss()
            if let itemsProvider = results.first?.itemProvider, itemsProvider.canLoadObject(ofClass: UIImage.self) {
                itemsProvider.loadObject(ofClass: UIImage.self) {[weak self] (image, error) in
                    DispatchQueue.main.async {
                        guard let self = self,
                              let image = image as? UIImage
                        else {
                            print("Not uiImage")
                            return }
                        self.parent.image = Image(uiImage: image)
                    }
                }
            } else {
                print("Can't load image")
            }
            
        }
        
        
    }
    
}
