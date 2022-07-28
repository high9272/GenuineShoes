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
    
    func testprint(){
        posts.removeAll()
        fetchPosts()
        print("리프레시 완료")

    }
    
    let db = Firestore.firestore()
    let uid = Auth.auth().currentUser?.uid
    private var posts = [PostModel]()
    private let storage = Storage.storage().reference()

    
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
            
            print("업로드 포스트컨트롤러가 나타납니다")
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: false)
        }
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {return}
        
   

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)

    }
    
    @objc func handleRefresh(){
        posts.removeAll()
        fetchPosts()
        
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTableView.register(UserTableViewCell.self, forCellReuseIdentifier: "UserTableViewCell")
        setupNavigationBar()
        fetchPosts()
        tableViewRefresh()
        view.addSubview(myTableView)
        myTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
      
    }
    
    func fetchPosts(){
        PostService.fetchPosts { posts in
            self.posts = posts
            self.myTableView.refreshControl?.endRefreshing()
            self.myTableView.reloadData()
          
        }
        
    }
    
    
    func tableViewRefresh(){
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        myTableView.refreshControl = refresher
        
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
    
        return 550
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath)
                as? UserTableViewCell else {return UITableViewCell()}
        cell.delegate = self //----->>>중요!!!!
        cell.selectionStyle = .none //셀을 클릭했을때 회색으로 변하지 않게 하기
        cell.backgroundColor = .systemBackground
        cell.viewModel = PostViewModel(post: posts[indexPath.row])
        return cell
        
    }
    
    
}
extension UserCheckViewController: FeedCellDelegate {

    
    func cell(_ cell: UserTableViewCell, didLike post: PostModel) {
        print("좋아요 버튼을 눌렀습니다.")

    }
    
    func cell(_ cell: UserTableViewCell, didUnLike post: PostModel) {
        print("싫어요 버튼을 눌렀습니다.")
    }
    
    func cell(_ cell: UserTableViewCell, wantToCommentView post: PostModel) {
        let controller = CommentController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    
    
}
