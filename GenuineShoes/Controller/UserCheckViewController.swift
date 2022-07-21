//
//  UserCheckViewController.swift
//  GenuineShoes
//
//  Created by DaWoon Jeong on 2022/07/16.
//

import Foundation
import UIKit
import SnapKit
import FirebaseDatabase
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import YPImagePicker

class UserCheckViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    let db = Firestore.firestore()

    let uid = Auth.auth().currentUser?.uid

    
    
    
    var selectedImage: UIImage? {
        didSet{myImage.image = selectedImage}
    }
    private let storage = Storage.storage().reference()
    
    lazy var myImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var imageLabel: UILabel = {
        let label = UILabel()
        label.text = "sdsdsds"
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
        
    }()

    
    @objc func uploadImageBtnTapped(){
        
        var config = YPImagePickerConfiguration()
        config.library.mediaType = .photo
        config.shouldSaveNewPicturesToAlbum = false
        config.startOnScreen = .library
        config.screens = [.library]
        config.library.maxNumberOfItems = 3

        let picker = YPImagePicker(configuration: config)
        picker.modalPresentationStyle = .fullScreen
        present(picker, animated: true)
        didFishedPickingMedia(picker)
    }
    func didFishedPickingMedia(_ picker: YPImagePicker){
        picker.didFinishPicking { items, _ in
            picker.dismiss(animated: true)
            guard let selectedImage = items.singlePhoto?.image else {return}
            print("선택한 이미지는 \(selectedImage)")
            
            let controller = UploadPostController()
            controller.selectedImage = selectedImage
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: false)
        }
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {return}
//
//        guard let imageData = image.pngData() else {return}
//
//
//        guard let image = selectedImage else {return}
//
//        PostService.uploadPost(image: image) { err in
//            if let err = err {
//                print(err)
//            }
//            self.dismiss(animated: true)
//        }
//
        
//
//        storage.child("images/file.png").putData(imageData, metadata: nil, completion: {_, error in
//            guard error == nil else {
//                print("Failed To Upload")
//                return
//            }
//
//            self.storage.child("images/file.png").downloadURL(completion: {url, error in
//
//                guard let url = url, error == nil else{
//                    return
//                }
//
//                let urlString = url.absoluteString
//
//                DispatchQueue.main.async {
//                    self.imageLabel.text = urlString
//                    self.myImage.image = image
//                }
//                print("download url: \(urlString)")
//                UserDefaults.standard.set(urlString, forKey: "url")
//
//
//            })
//
//        })
//
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
        
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupLayout()
//        guard let urlString = UserDefaults.standard.value(forKey: "url") as? String,
//        let url = URL(string: urlString)
//        
//        
//        else {return}
//        imageLabel.text = urlString
//
//        let task = URLSession.shared.dataTask(with: url) { data, _, error in
//            guard let data = data, error == nil else {return}
//
//            DispatchQueue.main.async {
//                let image = UIImage(data: data)
//                self.myImage.image = image
//            }
//        }
//        task.resume()
        
    }
    
    

    
    func setupLayout(){
        
        [myImage, imageLabel].forEach { view.addSubview($0)}
        
        myImage.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.height.width.equalTo(300)
        }
        imageLabel.snp.makeConstraints { make in
            make.top.equalTo(myImage.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
        }
  
    }
    
}



extension UserCheckViewController {
    
    func setupNavigationBar(){
        
        lazy var logoLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont(name: "Copperplate-Bold", size: 25)
            label.text = "GenuineShoes"
            label.textAlignment = .center
            return label
        }()
        navigationItem.titleView = logoLabel
        
        
        
        let uploadBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(uploadImageBtnTapped))
        self.navigationItem.rightBarButtonItem  = uploadBarButtonItem
        

        
        
    }
    
}

