//
//  ImagePicker.swift
//  CoinMarket
//
//  Created by Anh Nguyễn on 22/09/2023.
//
/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Nguyen Hung Anh
  ID: s3877798
  Created  date: 22/09/2023
  Last modified: 22/09/2023
  Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary // You can also use .camera if you want to allow taking a photo
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImage = info[.originalImage] as? UIImage {
                parent.image = selectedImage
            }
            picker.dismiss(animated: true)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
}

