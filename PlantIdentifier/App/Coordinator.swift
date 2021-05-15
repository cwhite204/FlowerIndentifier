//
//  Coordinator.swift
//  PlantIdentifier
//
//  Created by Christopher on 01/05/2021.
//

import SwiftUI

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
  @Binding var isCoordinatorShown: Bool
  var imageInCoordinator: UIImage?
    
  init(isShown: Binding<Bool>, image: UIImage?) {
    _isCoordinatorShown = isShown
    imageInCoordinator = image
  }
    
  func imagePickerController(_ picker: UIImagePickerController,
                didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
     guard let unwrapImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
     imageInCoordinator = unwrapImage
     isCoordinatorShown = false
  }
    
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
     isCoordinatorShown = false
  }
}
