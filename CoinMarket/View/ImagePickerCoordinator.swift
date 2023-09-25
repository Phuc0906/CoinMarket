//
//  ImagePickerCoordinator.swift
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

import Foundation
import SwiftUI
import UIKit

class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var parent: ProfileView

    init(_ parent: ProfileView) {
        self.parent = parent
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            parent.profileImage = selectedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

