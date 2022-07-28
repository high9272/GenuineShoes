//
//  ImageUploader.swift
//  GenuineShoes
//
//  Created by DaWoon Jeong on 2022/07/19.
//

import Foundation
import UIKit
import FirebaseStorage
import Firebase

struct ImageUploader {
    static func uploadImage(image: UIImage, completion: @escaping(String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.75) else {return}
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/postImages/\(filename)")
        
        ref.putData(imageData, metadata: nil) { metaData, error in
            if let error = error {
                print("failed to upload \(error.localizedDescription)")
                return
            }
            ref.downloadURL { (url, error) in
                guard let imageUrl = url?.absoluteString else {return}
                completion(imageUrl)
            }
        }
    }
}
