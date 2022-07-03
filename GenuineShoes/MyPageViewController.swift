//
//  MyPageViewController.swift
//  GenuineShoes
//
//  Created by DaWoon Jeong on 2022/06/28.
//

import Foundation
import UIKit
import Firebase
import GoogleSignIn
import FirebaseDatabase

class MyPageViewController: UIViewController {
    
    
    var models: [Model] = []
    let db = Database.database().reference()
    
    
    
    @IBOutlet weak var logoutBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUser()
        print("--------->\(models.count)")
        
        
        
    }
    
    
    
    //MARK: 로그아웃 코드
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            //viewController.navigationController?.popToRootViewController(animated: false)
            
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let mainViewController = storyboard.instantiateViewController(identifier: "LoginViewController")
            mainViewController.modalPresentationStyle = .fullScreen
            present(mainViewController, animated: false)
            
        } catch let signOutError as NSError {
            print("ERROR: signout \(signOutError.localizedDescription)")
        }
    }
    
    
    
    
    //MARK: 데이터 페치 코드
    func fetchUser(){
        self.db.child("mydata").observeSingleEvent(of: .value) { snapshot in
            guard let snapData = snapshot.value as? [String:AnyObject] else {return}
            let data = try! JSONSerialization.data(withJSONObject: Array(snapData.values), options: [])
            print(snapshot)
            
            do{
                let decoder = JSONDecoder()
                let modelList = try decoder.decode([Model].self, from: data)
                self.models = modelList
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }catch let error{
                print("\(error.localizedDescription)")
            }
            
        }
    }
    
    
    
}



//MARK: 테이블뷰 데이터 관리
extension MyPageViewController:UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        return 270
        
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
        
        
        
        
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? CustomCell else {return UITableViewCell()}
        let model = models[indexPath.row]
        
        cell.brandLabel.text = model.modelName
        //cell.imageUrlLabel.text = model[indexPath.row].imageUrl
        
        if let imageUrl = model.imageUrl {
            cell.snkImage.loadImageUsingCacheWithUrlString(imageUrl)
        }
  
        return cell
    }
    
  
}





