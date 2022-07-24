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

    private var posts = [PostModel]()
    
    private let storage = Storage.storage().reference()
    
//
//
//    var selectedImage: UIImage? {
//        didSet{myImage.image = selectedImage}
//    }
//
    

    
//    lazy var myImage: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFit
//        return imageView
//    }()
//
//    lazy var imageLabel: UILabel = {
//        let label = UILabel()
//        label.text = "sdsdsds"
//        label.numberOfLines = 0
//        label.textAlignment = .center
//        return label
//
//    }()

    
    lazy var myTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    @objc func uploadImageBtnTapped(){
        
        var config = YPImagePickerConfiguration()
        config.library.mediaType = .photo
        config.shouldSaveNewPicturesToAlbum = false
        config.startOnScreen = .library
        config.showsPhotoFilters = false
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
        self.myTableView.register(UserTableViewCell.self, forCellReuseIdentifier: "UserTableViewCell")
        setupNavigationBar()
        setupLayout()
        fetchPosts()
        view.addSubview(myTableView)
        myTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
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
    
    func fetchPosts(){
        PostService.fetchPosts { posts in
            self.posts = posts
            self.myTableView.reloadData()
            
        }
        
    }
    

    
    func setupLayout(){
        
        [].forEach { view.addSubview($0)}
        

  
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

extension UserCheckViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        return 600
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath)
                as? UserTableViewCell else {return UITableViewCell()}
        cell.backgroundColor = .systemBackground
        cell.viewModel = PostViewModel(post: posts[indexPath.row])
        return cell
        
    }
    
    
}
