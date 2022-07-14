//
//  HomeViewController.swift
//  GenuineShoes
//
//  Created by DaWoon Jeong on 2022/06/28.
//

import Foundation
import UIKit
import Firebase
import GoogleSignIn
import FirebaseDatabase
import SnapKit
//import CodableFirebase


class HomeViewController: UIViewController {
 
    var shoesModels = [ShoesModel]()
    
    var ref: DatabaseReference! //FireBase RealTime Database
    var shoesmodel: ShoesModel?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    //MARK: VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        //ShoesService.fetchData(completion: shoesModels)
        self.tableView.register(CustomCell.self, forCellReuseIdentifier: "customCell")
        tableView.dataSource = self
        tableView.delegate = self
        
       
        fetchUser()
        //ShoesService.fetchData()
        //setupNavigationBarButton()
        
        //MARK: 네비게이션 백버튼 숨기기
        //self.navigationItem.setHidesBackButton(true, animated: true)// 네비게이션컨트롤러 back버튼 숨기기
        
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
          
            
        }
        

        
        
    }
    
    
    
    //MARK: 데이터 페치 코드
    func fetchUser(){
        db.observeSingleEvent(of: .value) { snapshot in
            guard let snapData = snapshot.value as? [String:AnyObject] else {return}
            let data = try! JSONSerialization.data(withJSONObject: Array(snapData.values), options: [])
            //print(snapshot)
            
            do{
                let decoder = JSONDecoder()
                let modelList: [ShoesModel] = try decoder.decode([ShoesModel].self, from: data)
                self.shoesModels = modelList
                
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
extension HomeViewController:UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailViewController = DetailViewController()
        self.navigationController?.pushViewController(detailViewController, animated: true)
        //디테일뷰 컨트롤러에 detail 정보를 인덱스패스로 넘겨줌
        detailViewController.detail = shoesModels[indexPath.row].detail
        
        
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoesModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? CustomCell else {return UITableViewCell()}
        cell.selectionStyle = .none
        let model = shoesModels[indexPath.row]
        cell.modelLabel.text = model.modelName
        cell.brandLabel.text = model.brandName
 
        

        if let imageUrl = model.imageUrl {
            cell.snkImage.loadImageUsingCacheWithUrlString(imageUrl)

        }
        
        return cell
    }
    
    
}
