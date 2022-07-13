//
//  SearchViewController.swift
//  GenuineShoes
//
//  Created by DaWoon Jeong on 2022/07/04.
//

import Foundation
import UIKit
import SnapKit
import Firebase
import FirebaseDatabase

class SearchViewController: UIViewController {
    
    var shoesModels = [ShoesModel]()
    var filteredShoes = [ShoesModel]()
    
    let db = Database.database().reference()
    var ref: DatabaseReference! //FireBase RealTime Database

    var inSearchMode: Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
        
    }
    

    
    
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "신발 이름을 입력해주세요"
       
        return searchController
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.isHidden = true
        
        ref = Database.database().reference()
        
        self.tableView.register(CustomCell.self, forCellReuseIdentifier: "customCell")
        tableView.dataSource = self
        tableView.delegate = self
        setupLayout()
        navigationItem.searchController = searchController
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "신발 검색하기"
        print("------>\(shoesModels.count)")
        searchController.searchResultsUpdater = self
        fetchUser()
    }
    
    func setupLayout(){
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    func fetchUser(){
        self.db.child("mydata").observeSingleEvent(of: .value) { snapshot in
            guard let snapData = snapshot.value as? [String:AnyObject] else {return}
            let data = try! JSONSerialization.data(withJSONObject: Array(snapData.values), options: [])
            //print(snapshot)
            
            do{
                let decoder = JSONDecoder()
                let modelList: [ShoesModel] = try decoder.decode([ShoesModel].self, from: data)
                self.shoesModels = modelList
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    
                    // self.myLabel.text = "\(modelList.count)"
                    
                    
                    
                    
                }
            }catch let error{
                print("\(error.localizedDescription)")
            }
            
        }
    }
    
}


extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        self.navigationController?.pushViewController(detailViewController, animated: true)
        //detailViewController.detail = shoesModels[indexPath.row].detail
        print("이것을 눌러썽요---->\(shoesModels[indexPath.row])")
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        
        return inSearchMode ? filteredShoes.count : shoesModels.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? CustomCell else {return UITableViewCell()}

        let models = inSearchMode ? filteredShoes[indexPath.row] : shoesModels[indexPath.row]
        
        
        
        cell.selectionStyle = .none
        
        cell.modelLabel.text = models.modelName
        cell.brandLabel.text = models.brandName
        // cell.modelLabel.text = models[indexPath.row].brandName
        if let imageUrl = models.imageUrl {
            cell.snkImage.loadImageUsingCacheWithUrlString(imageUrl)
        }
        
        return cell
    }
    
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let searchText = searchController.searchBar.text?.lowercased() else {return}
        
        filteredShoes = shoesModels.filter({ $0.nick.contains(searchText)})
        print("\(searchText)")
        print("---->필터링..\(filteredShoes)")
        self.tableView.reloadData()

    }
}
