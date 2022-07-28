//
//  PostService.swift
//  GenuineShoes
//
//  Created by DaWoon Jeong on 2022/07/20.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore


let collectionPost = Firestore.firestore().collection("posts")

struct PostService {
    static func uploadPost(caption: String, image: UIImage, completion: @escaping(String) -> Void ) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        ImageUploader.uploadImage(image: image) { imageUrl in
            let data = ["caption": caption, "timestamp": Timestamp(date: Date()), "likes": 0, "imageUrl": imageUrl, "owneruid": uid, ] as [String : Any]
            
            collectionPost.addDocument(data: data)
        }
        
    }
    
    static func fetchPosts(completion: @escaping([PostModel]) -> Void ){
        collectionPost.order(by: "timestamp", descending: true).getDocuments { (snapshot, error) in
            
            guard let docments = snapshot?.documents else {return}
            
            
            let posts = docments.map({ PostModel(postId: $0.documentID, dictionary: $0.data())})
            completion(posts)
        }
        
        
        //            documnets.forEach { doc in
        //                print("doc data is \(doc.data())")
    }
}


