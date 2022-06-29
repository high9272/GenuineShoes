//
//  HomeViewController.swift
//  GenuineShoes
//
//  Created by DaWoon Jeong on 2022/06/28.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseStorage


class HomeViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private let storage = Storage.storage().reference()
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let urlString = UserDefaults.standard.value(forKey: "url") as? String,
              let url = URL(string: urlString) else {
            return
            
            
        }
        let task = URLSession.shared.dataTask(with: url, completionHandler: {data, _, error in
            
            guard let data = data, error == nil else {
                return
                
            }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.imageView.image = image
            }
        })
        task.resume()
    }
    
    @IBAction func uploadButtonTapped(_ sender: UIBarButtonItem) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        guard let imageData = image.pngData() else {
            return
        }
        
       
        
        storage.child("images/file.png").putData(imageData, metadata: nil, completion: { _, error in
            guard error == nil else {
                print("Failed to upload ")
                return
            }
            self.storage.child("images/file.png").downloadURL { url, error in
                guard let url = url, error == nil else { return }
                let urlString = url.absoluteString
                print("\(urlString)")
                UserDefaults.standard.set(urlString, forKey: "url")
                
            }
            
            
        })
         //upload image data
        // get download url
        // save download url to user defaults
        
    }

   
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    
    
}

