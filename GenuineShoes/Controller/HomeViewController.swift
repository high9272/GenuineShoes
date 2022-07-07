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
import CodableFirebase


class HomeViewController: UIViewController {
    //    var mydata: Model?
    var models = [Model]()
    let db = Database.database().reference()
    var ref: DatabaseReference! //FireBase RealTime Database
    
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    private lazy var myLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "dasndasnjadsn"
        label.textAlignment = .center
        
        
        return label
    }()
    
    
    //MARK: VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        self.tableView.register(CustomCell.self, forCellReuseIdentifier: "customCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        
        fetchUser()
        //setupNavigationBarButton()
        
        //MARK: 네비게이션 백버튼 숨기기
        //self.navigationItem.setHidesBackButton(true, animated: true)// 네비게이션컨트롤러 back버튼 숨기기
        
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(600)
            
        }
        
        view.addSubview(myLabel)
        myLabel.snp.makeConstraints { make in
            //make.top.equalTo(tableView.snp.bottom)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            
        }
        
    }
    
    //    func setupNavigationBarButton(){
    //        let settingButton = UIButton(type: .custom)
    //        settingButton.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
    //        settingButton.setImage(UIImage(systemName: "gearshape.fill"), for: .normal)
    //        settingButton.addTarget(self, action: #selector(settingButtonTapped), for: .touchUpInside)
    //        let settingBarButton = UIBarButtonItem(customView: settingButton)
    //
    //        let navItems = [settingBarButton]
    //
    //        navigationItem.rightBarButtonItems = navItems
    //
    //    }
    //
    //    @objc func settingButtonTapped(){
    //        self.navigationController?.pushViewController(SettingViewController(), animated: true)
    //
    //    }
    
    
    //MARK: 데이터 페치 코드
    func fetchUser(){
        self.db.child("mydata").observeSingleEvent(of: .value) { snapshot in
            guard let snapData = snapshot.value as? [String:AnyObject] else {return}
            let data = try! JSONSerialization.data(withJSONObject: Array(snapData.values), options: [])
            //print(snapshot)
            
            do{
                let decoder = JSONDecoder()
                let modelList: [Model] = try decoder.decode([Model].self, from: data)
                self.models = modelList
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.myLabel.text = "\(modelList.count)"
                    
                    
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
        detailViewController.detail = models[indexPath.row].detail
        
        
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? CustomCell else {return UITableViewCell()}
        cell.selectionStyle = .none
        let model = models[indexPath.row]
        cell.modelLabel.text = model.modelName
        cell.brandLabel.text = model.brandName
        //cell.modelLabel.text = models[indexPath.row].brandName
        if let imageUrl = model.imageUrl {
            cell.snkImage.loadImageUsingCacheWithUrlString(imageUrl)
        }
        
        return cell
    }
    
    
}


